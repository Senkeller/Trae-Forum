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
            layoutManager =