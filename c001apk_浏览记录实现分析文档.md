# c001apk 浏览记录功能实现分析文档

## 目录
1. [概述](#一概述)
2. [架构设计](#二架构设计)
3. [数据层实现](#三数据层实现)
4. [Repository层实现](#四repository层实现)
5. [ViewModel层实现](#五viewmodel层实现)
6. [UI层实现](#六ui层实现)
7. [浏览记录保存机制](#七浏览记录保存机制)
8. [依赖注入配置](#八依赖注入配置)
9. [可借鉴的设计要点](#九可借鉴的设计要点)
10. [核心代码文件清单](#十核心代码文件清单)

---

## 一、概述

本文档详细分析 c001apk 项目中浏览记录功能的实现机制。该功能采用 **MVVM + Repository + Room** 架构模式，实现了本地浏览历史的记录、查询、删除等功能，同时复用同一套架构支持本地收藏功能。

### 1.1 功能特性
- 自动记录用户浏览的 Feed 内容
- 支持浏览历史列表展示（按时间倒序）
- 支持单条删除和全部清空
- 用户可设置是否开启记录
- 自动去重，同一 Feed 只记录一次
- 横竖屏适配（竖屏单列/横屏双列）

### 1.2 技术栈
- **数据库**: Room (SQLite)
- **架构模式**: MVVM
- **依赖注入**: Hilt
- **异步处理**: Kotlin Coroutines + Flow/LiveData
- **UI**: RecyclerView + ListAdapter + ViewBinding

---

## 二、架构设计

### 2.1 整体架构图

```
┌─────────────────────────────────────────────────────────────────┐
│                         UI 层 (Activity/Adapter)                 │
│                    HistoryActivity / HistoryAdapter               │
└───────────────────────────────┬─────────────────────────────────┘
                                │
┌───────────────────────────────▼─────────────────────────────────┐
│                      ViewModel 层                                │
│                     HistoryViewModel                             │
└───────────────────────────────┬─────────────────────────────────┘
                                │
┌───────────────────────────────▼─────────────────────────────────┐
│                     Repository 层                                │
│                  HistoryFavoriteRepo                             │
└───────────────────────────────┬─────────────────────────────────┘
                                │
┌───────────────────────────────▼─────────────────────────────────┐
│                        DAO 层                                    │
│                  HistoryFavoriteDao                              │
└───────────────────────────────┬─────────────────────────────────┘
                                │
┌───────────────────────────────▼─────────────────────────────────┐
│                     Database 层                                  │
│              BrowseHistoryDatabase (Room)                        │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 数据流向

```
用户点击Feed
    ↓
BaseAppViewModel.onViewFeed()
    ↓
HistoryFavoriteRepo.saveHistory()
    ↓
HistoryFavoriteDao.insert() → Room Database
    ↓
LiveData自动通知观察者
    ↓
HistoryActivity 刷新列表
```

---

## 三、数据层实现

### 3.1 实体类设计

**文件路径**: `app/src/main/java/com/example/c001apk/logic/model/FeedEntity.kt`

```kotlin
package com.example.c001apk.logic.model

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Feed浏览记录实体类
 * 用于存储浏览历史和本地收藏的数据结构
 */
@Entity
data class FeedEntity(
    val fid: String,        // Feed ID (业务主键，用于去重)
    val uid: String,        // 用户ID
    val uname: String,      // 用户名
    val avatar: String,     // 用户头像URL
    val device: String,     // 设备信息
    val message: String,    // 内容摘要
    val pubDate: String     // 发布时间
) {
    /**
     * 数据库自增主键
     * 用于按插入顺序排序（时间倒序）
     */
    @PrimaryKey(autoGenerate = true)
    var id: Long = 0
}
```

#### 设计要点
| 字段 | 类型 | 说明 |
|------|------|------|
| `fid` | String | 业务主键，Feed的唯一标识，用于去重判断 |
| `uid` | String | 发布者用户ID |
| `uname` | String | 发布者用户名 |
| `avatar` | String | 发布者头像URL |
| `device` | String | 发布设备信息 |
| `message` | String | Feed内容摘要 |
| `pubDate` | String | 发布时间戳 |
| `id` | Long | 数据库自增主键，用于排序 |

#### 设计亮点
1. **双主键策略**: `fid` 用于业务去重，`id` 用于数据库排序
2. **精简字段**: 只存储展示所需的核心信息，不存储完整内容
3. **复用性**: 同一实体类同时用于浏览历史和本地收藏

### 3.2 数据库定义

**文件路径**: `app/src/main/java/com/example/c001apk/logic/database/BrowseHistoryDatabase.kt`

```kotlin
package com.example.c001apk.logic.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.c001apk.logic.dao.HistoryFavoriteDao
import com.example.c001apk.logic.model.FeedEntity

/**
 * 浏览历史数据库
 * 使用Room框架管理本地SQLite数据库
 */
@Database(version = 1, entities = [FeedEntity::class])
abstract class BrowseHistoryDatabase : RoomDatabase() {
    /**
     * 获取浏览历史DAO实例
     */
    abstract fun browseHistoryDao(): HistoryFavoriteDao
}
```

#### 配置说明
- **版本号**: `version = 1`，数据库结构变更时需升级版本
- **实体列表**: `[FeedEntity::class]`，可包含多个实体类
- **抽象方法**: 返回对应的DAO接口

### 3.3 收藏数据库

**文件路径**: `app/src/main/java/com/example/c001apk/logic/database/FeedFavoriteDatabase.kt`

```kotlin
package com.example.c001apk.logic.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.c001apk.logic.dao.HistoryFavoriteDao
import com.example.c001apk.logic.model.FeedEntity

/**
 * 本地收藏数据库
 * 与浏览历史使用相同的实体类和DAO接口
 */
@Database(version = 2, entities = [FeedEntity::class])
abstract class FeedFavoriteDatabase : RoomDatabase() {
    abstract fun feedFavoriteDao(): HistoryFavoriteDao
}
```

### 3.4 DAO接口

**文件路径**: `app/src/main/java/com/example/c001apk/logic/dao/HistoryFavoriteDao.kt`

```kotlin
package com.example.c001apk.logic.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.example.c001apk.logic.model.FeedEntity
import kotlinx.coroutines.flow.Flow

/**
 * 浏览历史/收藏 数据访问对象
 * 定义数据库操作接口
 */
@Dao
interface HistoryFavoriteDao {

    /**
     * 插入单条记录
     * @param data Feed实体对象
     */
    @Insert
    suspend fun insert(data: FeedEntity)

    /**
     * 查询所有记录（挂起函数）
     * @return 按id倒序排列的Feed列表
     */
    @Query("SELECT * FROM FeedEntity ORDER BY id DESC")
    suspend fun loadAllList(): List<FeedEntity>

    /**
     * 查询所有记录（LiveData方式）
     * 数据变化时自动通知观察者
     * @return LiveData包装的Feed列表
     */
    @Query("SELECT * FROM FeedEntity ORDER BY id DESC")
    fun loadAllListLive(): LiveData<List<FeedEntity>>

    /**
     * 查询所有记录（Flow方式）
     * 支持响应式流处理
     * @return Flow包装的Feed列表
     */
    @Query("SELECT * FROM FeedEntity ORDER BY id DESC")
    fun loadAllListFlow(): Flow<List<FeedEntity>>

    /**
     * 检查指定fid的记录是否存在
     * @param fid Feed ID
     * @return true-存在，false-不存在
     */
    @Query("SELECT 1 FROM FeedEntity WHERE fid = :fid LIMIT 1")
    suspend fun isExist(fid: String): Boolean

    /**
     * 删除指定fid的记录
     * @param fid Feed ID
     */
    @Query("DELETE FROM FeedEntity WHERE fid = :fid")
    suspend fun delete(fid: String)

    /**
     * 删除所有记录
     */
    @Query("DELETE FROM FeedEntity")
    suspend fun deleteAll()
}
```

#### 方法说明

| 方法 | 返回类型 | 说明 |
|------|----------|------|
| `insert()` | Unit | 插入单条记录，使用`@Insert`注解自动生成SQL |
| `loadAllList()` | `List<FeedEntity>` | 挂起函数，适用于一次性查询 |
| `loadAllListLive()` | `LiveData<List<FeedEntity>>` | 自动感知数据变化，适用于UI观察 |
| `loadAllListFlow()` | `Flow<List<FeedEntity>>` | 响应式流，适用于复杂数据处理 |
| `isExist()` | Boolean | 检查记录是否存在，用于去重 |
| `delete()` | Unit | 删除指定记录 |
| `deleteAll()` | Unit | 清空所有记录 |

#### 设计亮点
1. **多返回类型支持**: 同时提供`List`、`LiveData`、`Flow`三种方式，适应不同场景
2. **自动SQL生成**: 使用`@Insert`注解，Room自动生成插入SQL
3. **自定义查询**: 使用`@Query`注解编写自定义SQL
4. **协程支持**: 所有方法标记为`suspend`，支持协程调用

---

## 四、Repository层实现

### 4.1 HistoryFavoriteRepo

**文件路径**: `app/src/main/java/com/example/c001apk/logic/repository/HistoryFavoriteRepo.kt`

```kotlin
package com.example.c001apk.logic.repository

import androidx.lifecycle.LiveData
import com.example.c001apk.di.BrowseHistory
import com.example.c001apk.di.FeedFavorite
import com.example.c001apk.logic.dao.HistoryFavoriteDao
import com.example.c001apk.logic.model.FeedEntity
import javax.inject.Inject
import javax.inject.Singleton

/**
 * 浏览历史/收藏 数据仓库
 * 封装数据访问逻辑，为ViewModel提供统一的数据接口
 * 
 * 使用@Singleton确保全局唯一实例
 * 使用Hilt进行依赖注入
 */
@Singleton
class HistoryFavoriteRepo @Inject constructor(
    @BrowseHistory
    private val browseHistoryDao: HistoryFavoriteDao,
    @FeedFavorite
    private val feedFavoriteDao: HistoryFavoriteDao,
) {

    // ==================== 浏览历史相关方法 ====================

    /**
     * 获取浏览历史列表（LiveData）
     * @return LiveData包装的Feed列表
     */
    fun loadAllHistoryListLive(): LiveData<List<FeedEntity>> {
        return browseHistoryDao.loadAllListLive()
    }

    /**
     * 插入浏览历史
     * @param history Feed实体对象
     */
    suspend fun insertHistory(history: FeedEntity) {
        browseHistoryDao.insert(history)
    }

    /**
     * 检查浏览历史是否存在
     * @param fid Feed ID
     * @return true-存在，false-不存在
     */
    suspend fun checkHistory(fid: String): Boolean {
        return browseHistoryDao.isExist(fid)
    }

    /**
     * 保存浏览历史（带去重检查）
     * 如果记录已存在则不会重复插入
     * 
     * @param fid Feed ID
     * @param uid 用户ID
     * @param uname 用户名
     * @param avatar 用户头像
     * @param device 设备信息
     * @param message 内容摘要
     * @param pubDate 发布时间
     */
    suspend fun saveHistory(
        fid: String,
        uid: String,
        uname: String,
        avatar: String,
        device: String,
        message: String,
        pubDate: String
    ) {
        // 先去重检查，避免重复记录
        if (!browseHistoryDao.isExist(fid))
            browseHistoryDao.insert(
                FeedEntity(
                    fid,
                    uid,
                    uname,
                    avatar,
                    device,
                    message,
                    pubDate
                )
            )
    }

    /**
     * 删除指定浏览历史
     * @param fid Feed ID
     */
    suspend fun deleteHistory(fid: String) {
        browseHistoryDao.delete(fid)
    }

    /**
     * 清空所有浏览历史
     */
    suspend fun deleteAllHistory() {
        browseHistoryDao.deleteAll()
    }

    // ==================== 本地收藏相关方法 ====================

    /**
     * 获取收藏列表（LiveData）
     * @return LiveData包装的Feed列表
     */
    fun loadAllFavoriteListLive(): LiveData<List<FeedEntity>> {
        return feedFavoriteDao.loadAllListLive()
    }

    /**
     * 插入收藏
     * @param favorite Feed实体对象
     */
    suspend fun insertFavorite(favorite: FeedEntity) {
        feedFavoriteDao.insert(favorite)
    }

    /**
     * 检查收藏是否存在
     * @param fid Feed ID
     * @return true-存在，false-不存在
     */
    suspend fun checkFavorite(fid: String): Boolean {
        return feedFavoriteDao.isExist(fid)
    }

    /**
     * 保存收藏（带去重检查）
     * @param fid Feed ID
     * @param uid 用户ID
     * @param uname 用户名
     * @param avatar 用户头像
     * @param device 设备信息
     * @param message 内容摘要
     * @param pubDate 发布时间
     */
    suspend fun saveFavorite(
        fid: String,
        uid: String,
        uname: String,
        avatar: String,
        device: String,
        message: String,
        pubDate: String
    ) {
        if (!feedFavoriteDao.isExist(fid))
            feedFavoriteDao.insert(
                FeedEntity(
                    fid,
                    uid,
                    uname,
                    avatar,
                    device,
                    message,
                    pubDate
                )
            )
    }

    /**
     * 删除指定收藏
     * @param fid Feed ID
     */
    suspend fun deleteFavorite(fid: String) {
        feedFavoriteDao.delete(fid)
    }

    /**
     * 清空所有收藏
     */
    suspend fun deleteAllFavorite() {
        feedFavoriteDao.deleteAll()
    }
}
```

#### 设计亮点

1. **单例模式**: 使用`@Singleton`确保全局唯一实例，避免重复创建
2. **多数据源支持**: 通过`@BrowseHistory`和`@FeedFavorite`注解区分两个数据源
3. **去重逻辑封装**: `saveHistory()`和`saveFavorite()`方法内部进行去重检查
4. **职责分离**: Repository层只负责数据访问，不涉及业务逻辑

---

## 五、ViewModel层实现

### 5.1 HistoryViewModel

**文件路径**: `app/src/main/java/com/example/c001apk/ui/history/HistoryViewModel.kt`

```kotlin
package com.example.c001apk.ui.history

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.c001apk.logic.model.FeedEntity
import com.example.c001apk.logic.repository.BlackListRepo
import com.example.c001apk.logic.repository.HistoryFavoriteRepo
import dagger.assisted.Assisted
import dagger.assisted.AssistedFactory
import dagger.assisted.AssistedInject
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * 浏览历史/收藏 ViewModel
 * 管理UI与数据层之间的交互
 * 
 * 使用@AssistedInject支持运行时参数注入（type）
 * 一个ViewModel同时支持浏览历史和本地收藏两种模式
 */
@HiltViewModel(assistedFactory = HistoryViewModel.Factory::class)
class HistoryViewModel @AssistedInject constructor(
    @Assisted val type: String,  // "browse" 或 "favorite"
    private val blackListRepo: BlackListRepo,
    private val historyRepo: HistoryFavoriteRepo,
) : ViewModel() {

    /**
     * AssistedFactory接口
     * 用于创建带参数的ViewModel实例
     */
    @AssistedFactory
    interface Factory {
        fun create(type: String): HistoryViewModel
    }

    /**
     * 数据流LiveData
     * 根据type类型返回对应的数据源
     */
    val browseLiveData: LiveData<List<FeedEntity>> =
        if (type == "browse") {
            historyRepo.loadAllHistoryListLive()
        } else {
            historyRepo.loadAllFavoriteListLive()
        }

    /**
     * 保存用户到黑名单
     * @param uid 用户ID
     */
    fun saveUid(uid: String) {
        viewModelScope.launch(Dispatchers.IO) {
            blackListRepo.saveUid(uid)
        }
    }

    /**
     * 清空所有记录
     * 根据type类型执行对应操作
     */
    fun deleteAll() {
        viewModelScope.launch(Dispatchers.IO) {
            when (type) {
                "browse" -> historyRepo.deleteAllHistory()
                "favorite" -> historyRepo.deleteAllFavorite()
                else -> {}
            }
        }
    }

    /**
     * 删除指定记录
     * @param fid Feed ID
     */
    fun delete(fid: String) {
        viewModelScope.launch(Dispatchers.IO) {
            when (type) {
                "browse" -> historyRepo.deleteHistory(fid)
                "favorite" -> historyRepo.deleteFavorite(fid)
                else -> {}
            }
        }
    }

    /**
     * 保存浏览历史
     * @param id Feed ID
     * @param uid 用户ID
     * @param username 用户名
     * @param userAvatar 用户头像
     * @param deviceTitle 设备信息
     * @param message 内容摘要
     * @param dateline 发布时间
     */
    fun saveHistory(
        id: String,
        uid: String,
        username: String,
        userAvatar: String,
        deviceTitle: String,
        message: String,
        dateline: String,
    ) {
        viewModelScope.launch(Dispatchers.IO) {
            historyRepo.saveHistory(
                id,
                uid,
                username,
                userAvatar,
                deviceTitle,
                message,
                dateline,
            )
        }
    }
}
```

#### 设计亮点

1. **AssistedInject模式**: 使用`@AssistedInject`实现带参数的ViewModel创建
2. **多模式支持**: 通过`type`参数区分浏览历史和收藏模式
3. **线程安全**: 所有数据库操作在`Dispatchers.IO`线程执行
4. **生命周期感知**: 使用`viewModelScope`确保协程在ViewModel销毁时自动取消

---

## 六、UI层实现

### 6.1 HistoryActivity

**文件路径**: `app/src/main/java/com/example/c001apk/ui/history/HistoryActivity.kt`

```kotlin
package com.example.c001apk.ui.history

import android.content.res.Configuration
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import androidx.activity.viewModels
import androidx.core.view.isVisible
import androidx.recyclerview.widget.ConcatAdapter
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.StaggeredGridLayoutManager
import com.example.c001apk.R
import com.example.c001apk.adapter.HeaderAdapter
import com.example.c001apk.adapter.ItemListener
import com.example.c001apk.databinding.ActivityHistoryBinding
import com.example.c001apk.ui.base.BaseActivity
import com.example.c001apk.util.PrefManager
import com.example.c001apk.util.dp
import com.example.c001apk.view.LinearItemDecoration
import com.example.c001apk.view.StaggerItemDecoration
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import dagger.hilt.android.AndroidEntryPoint
import dagger.hilt.android.lifecycle.withCreationCallback

/**
 * 浏览历史/收藏 页面
 * 使用Hilt进行依赖注入
 */
@AndroidEntryPoint
class HistoryActivity : BaseActivity<ActivityHistoryBinding>() {

    /**
     * 使用AssistedInject创建ViewModel
     * 传递type参数区分浏览历史和收藏模式
     */
    private val viewModel by viewModels<HistoryViewModel>(
        extrasProducer = {
            defaultViewModelCreationExtras.withCreationCallback<HistoryViewModel.Factory> { factory ->
                factory.create(type = intent.getStringExtra("type") ?: "browse")
            }
        }
    )
    
    private lateinit var mAdapter: HistoryAdapter
    private lateinit var mLayoutManager: LinearLayoutManager
    private lateinit var sLayoutManager: StaggeredGridLayoutManager
    
    /**
     * 判断当前是否为竖屏
     */
    private val isPortrait by lazy { 
        resources.configuration.orientation == Configuration.ORIENTATION_PORTRAIT 
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 根据类型设置页面标题
        binding.toolBar.title = when (viewModel.type) {
            "browse" -> "浏览历史"
            "favorite" -> "本地收藏"
            else -> throw IllegalArgumentException("error type: ${viewModel.type}")
        }

        initBar()
        initView()

        // 观察数据变化，自动刷新列表
        viewModel.browseLiveData.observe(this) { list ->
            mAdapter.submitList(list)
            binding.indicator.parent.isIndeterminate = false
            binding.indicator.parent.isVisible = false
        }
    }

    /**
     * 初始化Toolbar
     */
    private fun initBar() {
        setSupportActionBar(binding.toolBar)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    /**
     * 创建菜单
     */
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.history_menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    /**
     * 菜单项点击处理
     */
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> finish()

            R.id.clearAll -> {
                // 显示确认对话框
                MaterialAlertDialogBuilder(this).apply {
                    if (viewModel.type == "browse") 
                        setTitle("确定清除全部浏览历史？")
                    else 
                        setTitle("确定清除全部收藏？")
                    setNegativeButton(android.R.string.cancel, null)
                    setPositiveButton(android.R.string.ok) { _, _ ->
                        viewModel.deleteAll()
                    }
                    show()
                }
            }
        }
        return super.onOptionsItemSelected(item)
    }

    /**
     * 初始化RecyclerView
     * 支持竖屏单列/横屏双列布局
     */
    private fun initView() {
        // 显示加载指示器
        binding.indicator.parent.isIndeterminate = true
        binding.indicator.parent.isVisible = true

        mAdapter = HistoryAdapter(ItemClickListener())
        binding.recyclerView.apply {
            // 使用ConcatAdapter添加头部
            adapter = ConcatAdapter(HeaderAdapter(), mAdapter)
            
            // 根据屏幕方向选择布局管理器
            layoutManager = if (isPortrait) {
                mLayoutManager = LinearLayoutManager(this@HistoryActivity)
                mLayoutManager
            } else {
                sLayoutManager = StaggeredGridLayoutManager(
                    2, 
                    StaggeredGridLayoutManager.VERTICAL
                )
                sLayoutManager
            }
            
            // 添加分割线
            if (itemDecorationCount == 0) {
                if (isPortrait)
                    addItemDecoration(LinearItemDecoration(10.dp))
                else
                    addItemDecoration(StaggerItemDecoration(10.dp))
            }
        }
    }

    /**
     * 列表项点击监听器
     */
    inner class ItemClickListener : ItemListener {
        
        /**
         * 查看Feed详情
         * 同时保存浏览记录（如果开启设置）
         */
        override fun onViewFeed(
            view: View,
            id: String?,
            uid: String?,
            username: String?,
            userAvatar: String?,
            deviceTitle: String?,
            message: String?,
            dateline: String?,
            rid: Any?,
            isViewReply: Any?
        ) {
            super.onViewFeed(
                view, id, uid, username, userAvatar,
                deviceTitle, message, dateline, rid, isViewReply
            )
            
            // 保存浏览记录的条件：
            // 1. uid不为空
            // 2. 用户开启了记录历史设置
            if (!uid.isNullOrEmpty() && PrefManager.isRecordHistory)
                viewModel.saveHistory(
                    id.toString(), uid.toString(), 
                    username.toString(), userAvatar.toString(),
                    deviceTitle.toString(), message.toString(), 
                    dateline.toString()
                )
        }

        /**
         * 屏蔽用户
         */
        override fun onBlockUser(id: String, uid: String, position: Int) {
            viewModel.saveUid(uid)
            onDeleteClicked("", id, position)
        }

        /**
         * 删除记录
         */
        override fun onDeleteClicked(entityType: String, id: String, position: Int) {
            viewModel.delete(id)
        }
    }
}
```

#### 设计亮点

1. **多模式复用**: 一个Activity同时支持浏览历史和收藏两种模式
2. **横竖屏适配**: 竖屏使用`LinearLayoutManager`单列，横屏使用`StaggeredGridLayoutManager`双列
3. **ConcatAdapter**: 使用`ConcatAdapter`组合头部和列表适配器
4. **确认对话框**: 清空操作前显示确认对话框，防止误操作

### 6.2 HistoryAdapter

**文件路径**: `app/src/main/java/com/example/c001apk/ui/history/HistoryAdapter.kt`

```kotlin
package com.example.c001apk.ui.history

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.appcompat.widget.PopupMenu
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.c001apk.BR
import com.example.c001apk.R
import com.example.c001apk.adapter.ItemListener
import com.example.c001apk.adapter.PopClickListener
import com.example.c001apk.databinding.ItemHistoryFeedBinding
import com.example.c001apk.logic.model.FeedEntity
import com.example.c001apk.util.PrefManager

/**
 * 浏览历史/收藏 列表适配器
 * 使用ListAdapter实现数据差异更新
 */
class HistoryAdapter(
    private val listener: ItemListener
) : ListAdapter<FeedEntity, HistoryAdapter.HistoryViewHolder>(HistoryDiffCallback()) {

    /**
     * ViewHolder类
     * 使用ViewBinding绑定视图
     */
    class HistoryViewHolder(
        val binding: ItemHistoryFeedBinding, 
        val listener: ItemListener
    ) : RecyclerView.ViewHolder(binding.root) {
        
        var id: String = ""
        var uid: String = ""

        init {
            // 初始化弹出菜单
            binding.expand.setOnClickListener {
                PopupMenu(it.context, it).apply {
                    menuInflater.inflate(R.menu.feed_reply_menu, menu).apply {
                        menu.findItem(R.id.copy)?.isVisible = false
                        menu.findItem(R.id.show)?.isVisible = false
                        menu.findItem(R.id.report)?.isVisible = PrefManager.isLogin
                    }
                    setOnMenuItemClickListener(
                        PopClickListener(
                            listener, it.context, "feed", id, uid, bindingAdapterPosition
                        )
                    )
                    show()
                }
            }
        }

        /**
         * 绑定数据到视图
         * 使用DataBinding设置变量
         */
        fun bind(data: FeedEntity) {
            id = data.fid
            uid = data.uid

            binding.setVariable(BR.id, id)
            binding.setVariable(BR.uid, uid)
            binding.setVariable(BR.listener, listener)
            binding.setVariable(BR.username, data.uname)
            binding.setVariable(BR.avatarUrl, data.avatar)
            binding.setVariable(BR.deviceTitle, data.device)
            binding.setVariable(BR.dateline, data.pubDate.toLong())
            binding.setVariable(BR.messageContent, data.message)
            binding.executePendingBindings()
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): HistoryViewHolder {
        return HistoryViewHolder(
            ItemHistoryFeedBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            ), listener
        )
    }

    override fun onBindViewHolder(holder: HistoryViewHolder, position: Int) {
        holder.bind(currentList[position])
    }
}

/**
 * DiffUtil回调类
 * 用于计算列表数据差异，实现高效更新
 */
class HistoryDiffCallback : DiffUtil.ItemCallback<FeedEntity>() {
    
    /**
     * 判断是否为同一项（业务层面）
     */
    override fun areItemsTheSame(
        oldItem: FeedEntity,
        newItem: FeedEntity
    ): Boolean {
        return oldItem.fid == newItem.fid
    }

    /**
     * 判断内容是否相同（用于判断是否需要刷新UI）
     */
    override fun areContentsTheSame(
        oldItem: FeedEntity,
        newItem: FeedEntity
    ): Boolean {
        return oldItem.fid == newItem.fid
    }
}
```

#### 设计亮点

1. **ListAdapter**: 使用`ListAdapter`替代普通`RecyclerView.Adapter`，自动处理数据差异
2. **DiffUtil**: 使用`DiffUtil.ItemCallback`计算数据差异，只更新变化的项
3. **ViewBinding**: 使用`ItemHistoryFeedBinding`进行视图绑定，类型安全
4. **DataBinding**: 使用`setVariable()`设置绑定变量，实现数据和UI的自动同步

---

## 七、浏览记录保存机制

### 7.1 保存触发点

浏览记录保存的核心逻辑在 [BaseAppViewModel.kt](file:///Users/jason/Documents/codex/TraeU/traeu/c001apk/app/src/main/java/com/example/c001apk/ui/base/BaseAppViewModel.kt) 中：

```kotlin
package com.example.c001apk.ui.base

import android.view.View
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.example.c001apk.adapter.FooterState
import com.example.c001apk.adapter.ItemListener
import com.example.c001apk.constant.Constants
import com.example.c001apk.logic.model.HomeFeedResponse
import com.example.c001apk.logic.repository.BlackListRepo
import com.example.c001apk.logic.repository.HistoryFavoriteRepo
import com.example.c001apk.logic.repository.NetworkRepo
import com.example.c001apk.util.Event
import com.example.c001apk.util.PrefManager
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * 应用基础ViewModel
 * 封装通用的业务逻辑和数据处理
 */
abstract class BaseAppViewModel(
    val blackListRepo: BlackListRepo,
    val historyRepo: HistoryFavoriteRepo,
    val networkRepo: NetworkRepo
) : BaseViewModel() {

    val dataList = MutableLiveData<List<HomeFeedResponse.Data>>()
    val footerState = MutableLiveData<FooterState>()
    val toastText = MutableLiveData<Event<String?>>()

    /**
     * 列表项点击监听器
     * 封装通用的点击处理逻辑
     */
    inner class ItemClickListener : ItemListener {

        override fun onShowCollection(id: String, title: String) {
            showCollection(id, title)
        }

        /**
         * 查看Feed详情
         * 同时保存浏览记录（如果满足条件）
         */
        override fun onViewFeed(
            view: View,
            id: String?,
            uid: String?,
            username: String?,
            userAvatar: String?,
            deviceTitle: String?,
            message: String?,
            dateline: String?,
            rid: Any?,
            isViewReply: Any?
        ) {
            super.onViewFeed(
                view, id, uid, username, userAvatar,
                deviceTitle, message, dateline, rid, isViewReply
            )
            
            /**
             * 保存浏览记录的条件：
             * 1. uid不为空（确保是有效的Feed）
             * 2. 用户开启了记录历史设置 (PrefManager.isRecordHistory)
             */
            viewModelScope.launch(Dispatchers.IO) {
                if (!uid.isNullOrEmpty() && PrefManager.isRecordHistory)
                    historyRepo.saveHistory(
                        id.toString(), uid.toString(), 
                        username.toString(), userAvatar.toString(),
                        deviceTitle.toString(), message.toString(), 
                        dateline.toString()
                    )
            }
        }

        override fun onFollowUser(uid: String, followAuthor: Int) {
            if (PrefManager.isLogin) {
                val url = if (followAuthor == 1) 
                    "/v6/user/unfollow" 
                else 
                    "/v6/user/follow"
                onPostFollowUnFollow(url, uid, followAuthor)
            }
        }

        override fun onLikeClick(type: String, id: String, isLike: Int) {
            if (PrefManager.isLogin) {
                if (PrefManager.SZLMID.isEmpty())
                    toastText.postValue(Event(Constants.SZLM_ID))
                else if (type == "feed")
                    onPostLikeFeed(id, isLike)
                else
                    onPostLikeReply(id, isLike)
            }
        }

        override fun onBlockUser(id: String, uid: String, position: Int) {
            viewModelScope.launch(Dispatchers.IO) {
                blackListRepo.saveUid(uid)
            }
            val currentList = dataList.value?.toMutableList() ?: ArrayList()
            currentList.removeAt(position)
            dataList.postValue(currentList)
        }

        override fun onDeleteClicked(entityType: String, id: String, position: Int) {
            val url = if (entityType == "feed") 
                "/v6/feed/deleteFeed"
            else 
                "/v6/feed/deleteReply"
            onDeleteFeed(url, id, position)
        }
    }

    // ... 其他方法
}
```

### 7.2 用户设置

**文件路径**: `app/src/main/java/com/example/c001apk/util/PrefManager.kt`

```kotlin
object PrefManager {
    private val pref = context.getSharedPreferences("settings", MODE_PRIVATE)

    /**
     * 是否记录浏览历史
     * 默认开启（true）
     */
    var isRecordHistory: Boolean
        get() = pref.getBoolean("isRecordHistory", true)
        set(value) = pref.edit().putBoolean("isRecordHistory", value).apply()
}
```

### 7.3 调用链路图

```
用户点击Feed卡片
    ↓
触发 ItemListener.onViewFeed()
    ↓
BaseAppViewModel.ItemClickListener 拦截处理
    ↓
检查保存条件：
    ├─ uid != null ?
    └─ PrefManager.isRecordHistory == true ?
    ↓
调用 historyRepo.saveHistory()
    ↓
Repository层进行去重检查：browseHistoryDao.isExist(fid)
    ↓
如果不存在，插入数据库：browseHistoryDao.insert()
    ↓
LiveData自动通知观察者
    ↓
HistoryActivity 收到通知，刷新列表
```

---

## 八、依赖注入配置

### 8.1 DatabaseModule

**文件路径**: `app/src/main/java/com/example/c001apk/di/DatabaseModule.kt`

```kotlin
package com.example.c001apk.di

import android.content.Context
import androidx.room.Room
import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase
import com.example.c001apk.logic.dao.HistoryFavoriteDao
import com.example.c001apk.logic.database.BrowseHistoryDatabase
import com.example.c001apk.logic.database.FeedFavoriteDatabase
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Qualifier
import javax.inject.Singleton

/**
 * 限定符注解：用户黑名单
 */
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class UserBlackList

/**
 * 限定符注解：话题黑名单
 */
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class TopicBlackList

/**
 * 限定符注解：搜索历史
 */
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class SearchHistory

/**
 * 限定符注解：最近使用表情
 */
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class RecentEmoji

/**
 * 限定符注解：浏览历史
 */
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class BrowseHistory

/**
 * 限定符注解：Feed收藏
 */
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class FeedFavorite

/**
 * 数据库模块
 * 提供各种数据库和DAO的依赖注入
 */
@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    // ==================== 浏览历史数据库配置 ====================

    /**
     * 提供浏览历史DAO
     * 使用@BrowseHistory限定符区分
     */
    @BrowseHistory
    @Singleton
    @Provides
    fun provideBrowseHistoryDao(
        browseHistoryDatabase: BrowseHistoryDatabase
    ): HistoryFavoriteDao {
        return browseHistoryDatabase.browseHistoryDao()
    }

    /**
     * 提供浏览历史数据库实例
     */
    @Singleton
    @Provides
    fun provideBrowseHistoryDatabase(
        @ApplicationContext context: Context
    ): BrowseHistoryDatabase {
        return Room.databaseBuilder(
            context.applicationContext,
            BrowseHistoryDatabase::class.java,
            "browse_history.db"
        ).build()
    }

    // ==================== 收藏数据库配置 ====================

    /**
     * 提供收藏DAO
     * 使用@FeedFavorite限定符区分
     */
    @FeedFavorite
    @Singleton
    @Provides
    fun provideFeedFavoriteDao(
        feedFavoriteDatabase: FeedFavoriteDatabase
    ): HistoryFavoriteDao {
        return feedFavoriteDatabase.feedFavoriteDao()
    }

    /**
     * 提供收藏数据库实例
     * 包含数据库迁移配置
     */
    @Singleton
    @Provides
    fun provideFeedFavoriteDatabase(
        @ApplicationContext context: Context
    ): FeedFavoriteDatabase {
        return Room.databaseBuilder(
            context.applicationContext,
            FeedFavoriteDatabase::class.java,
            "feed_favorite.db"
        )
        .addMigrations(FeedFavoriteDatabase_MIGRATION_1_2)
        .build()
    }

    // ... 其他数据库配置
}

/**
 * 收藏数据库迁移：版本1升级到版本2
 * 修改表结构，添加新字段
 */
object FeedFavoriteDatabase_MIGRATION_1_2 : Migration(1, 2) {
    override fun migrate(db: SupportSQLiteDatabase) {
        db.execSQL(
            "CREATE TABLE FeedFavorite_new (" +
            "uid text not null, " +
            "uname TEXT not null, " +
            "feedId TEXT not null, " +
            "avatar TEXT not null, " +
            "id INTEGER not null, " +
            "message TEXT not null, " +
            "device TEXT not null, " +
            "pubDate TEXT not null, " +
            "PRIMARY KEY(id))"
        )
        db.execSQL("DROP TABLE FeedFavorite")
        db.execSQL("ALTER TABLE FeedFavorite_new RENAME TO FeedFavorite")
    }
}
```

### 8.2 依赖注入说明

| 注解 | 用途 |
|------|------|
| `@Module` | 标记为Hilt模块 |
| `@InstallIn(SingletonComponent::class)` | 模块安装在Singleton组件中 |
| `@Provides` | 提供依赖实例 |
| `@Singleton` | 单例模式 |
| `@Qualifier` | 限定符，用于区分同类型的不同实例 |
| `@BrowseHistory` | 标记浏览历史DAO |
| `@FeedFavorite` | 标记收藏DAO |

---

## 九、可借鉴的设计要点

### 9.1 架构设计

| 设计点 | 说明 | 优势 |
|--------|------|------|
| **MVVM架构** | 数据驱动UI | 职责分离，易于测试和维护 |
| **Repository模式** | 封装数据访问逻辑 | 统一数据接口，便于切换数据源 |
| **依赖注入** | 使用Hilt管理依赖 | 解耦组件，便于单元测试 |

### 9.2 数据设计

| 设计点 | 说明 | 优势 |
|--------|------|------|
| **双主键策略** | `fid`业务去重 + `id`排序 | 既保证唯一性又支持时间排序 |
| **自动去重** | 插入前检查`isExist()` | 避免重复数据 |
| **精简存储** | 只存展示所需字段 | 减少存储空间占用 |

### 9.3 异步处理

| 设计点 | 说明 | 优势 |
|--------|------|------|
| **协程+Room** | 所有DAO方法标记`suspend` | 编译时检查，避免主线程操作 |
| **LiveData** | 数据库变化自动通知UI | 响应式编程，减少手动刷新 |
| **Flow支持** | 同时提供Flow接口 | 支持复杂的数据流处理 |

### 9.4 UI优化

| 设计点 | 说明 | 优势 |
|--------|------|------|
| **ListAdapter+DiffUtil** | 自动计算数据差异 | 只刷新变化的项，性能优化 |
| **ViewBinding** | 编译时生成绑定类 | 类型安全，避免findViewById |
| **横竖屏适配** | 不同方向使用不同布局 | 提升用户体验 |

### 9.5 代码复用

| 设计点 | 说明 | 优势 |
|--------|------|------|
| **Entity复用** | 同一实体类用于历史和收藏 | 减少重复代码 |
| **DAO复用** | 同一DAO接口用于多个数据库 | 统一操作接口 |
| **ViewModel复用** | 通过type参数区分模式 | 一个类支持多种功能 |
| **Activity复用** | 通过Intent参数区分模式 | 减少Activity数量 |

---

## 十、核心代码文件清单

### 10.1 数据层

| 文件路径 | 职责 |
|----------|------|
| `logic/model/FeedEntity.kt` | 数据实体类定义 |
| `logic/database/BrowseHistoryDatabase.kt` | 浏览历史数据库定义 |
| `logic/database/FeedFavoriteDatabase.kt` | 收藏数据库定义 |
| `logic/dao/HistoryFavoriteDao.kt` | 数据访问对象接口 |

### 10.2 业务层

| 文件路径 | 职责 |
|----------|------|
| `logic/repository/HistoryFavoriteRepo.kt` | 数据仓库，封装数据库操作 |
| `di/DatabaseModule.kt` | 依赖注入配置 |

### 10.3 视图层

| 文件路径 | 职责 |
|----------|------|
| `ui/history/HistoryViewModel.kt` | 历史记录ViewModel |
| `ui/history/HistoryActivity.kt` | 历史记录页面 |
| `ui/history/HistoryAdapter.kt` | 列表适配器 |
| `ui/base/BaseAppViewModel.kt` | 基础ViewModel，包含保存记录逻辑 |

### 10.4 工具类

| 文件路径 | 职责 |
|----------|------|
| `util/PrefManager.kt` | 用户偏好设置管理 |

---

## 附录：完整调用时序图

```
用户点击Feed
    │
    ▼
┌─────────────────┐
│  ItemListener   │
│  onViewFeed()   │
└────────┬────────┘
         │
         ▼
┌─────────────────────────┐
│  BaseAppViewModel       │
│  ItemClickListener      │
│  检查isRecordHistory    │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  HistoryFavoriteRepo    │
│  saveHistory()          │
│  检查isExist()去重      │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  HistoryFavoriteDao     │
│  insert()               │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  Room Database          │
│  数据持久化             │
└────────┬────────────────┘
         │
         │ LiveData自动通知
         ▼
┌─────────────────────────┐
│  HistoryActivity        │
│  Observer回调           │
│  submitList()刷新列表   │
└─────────────────────────┘
```

---

**文档版本**: 1.0  
**创建日期**: 2026-04-25  
**项目**: c001apk  
**分析工具**: Trae AI Agent
