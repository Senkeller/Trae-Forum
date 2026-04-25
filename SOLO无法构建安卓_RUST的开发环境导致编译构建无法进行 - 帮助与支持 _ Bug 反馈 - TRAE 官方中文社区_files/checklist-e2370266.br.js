define("discourse/plugins/checklist/discourse/initializers/checklist",["exports","discourse/lib/ajax","discourse/lib/ajax-error","discourse/lib/icon-library","discourse/lib/plugin-api","discourse/plugins/checklist/lib/rich-editor-extension"],function(e,t,n,s,c,o){"use strict"
function i(e){return 3===e.nodeType&&e.nodeValue.match(/^\s*$/)}function r(e){e.forEach(e=>{let t=e.parentElement
"P"===t.nodeName&&t.parentElement.firstElementChild===t&&(t=t.parentElement),"LI"!==t.nodeName||"UL"!==t.parentElement.nodeName||function(e){let t=e.previousSibling
for(;t;){if(!i(t))return!0
t=t.previousSibling}return!1}(e)||(t.classList.add("has-checkbox"),e.classList.add("list-item-checkbox"),e.nextSibling||e.insertAdjacentHTML("afterend","&#8203;"))})}function l(e,c){const o=[...e.getElementsByClassName("chcklst-box")]
r(o)
const i=c?.getModel()
i?.can_edit&&o.forEach((e,c)=>{e.onclick=async e=>{const r=e.currentTarget,l=r.classList
if(l.contains("permanent")||l.contains("readonly"))return
const a=l.contains("checked")?"[ ]":"[x]",d=document.createElement("template")
d.innerHTML=(0,s.iconHTML)("spinner",{class:"fa-spin list-item-checkbox"}),r.insertAdjacentElement("afterend",d.content.firstChild),r.classList.add("hidden"),o.forEach(e=>e.classList.add("readonly"))
try{const e=await(0,t.ajax)(`/posts/${i.id}`),n=[];[/`[^`\n]*\n?[^`\n]*`/gm,/^```[^]*?^```/gm,/\[code\][^]*?\[\/code\]/gm,/_(?=\S).*?\S_/gm,/~~(?=\S).*?\S~~/gm].forEach(t=>{let s
for(;null!=(s=t.exec(e.raw));)n.push([s.index,s.index+s[0].length])}),[/([^\[\n]|^)\*\S.+?\S\*(?=[^\]\n]|$)/gm].forEach(t=>{let s
for(;null!=(s=t.exec(e.raw));)n.push([s.index+1,s.index+s[0].length])})
let s=-1,o=!1
const r=e.raw.replace(/\[( |x)?\]/gi,(t,i,r)=>o||r>0&&"!"===e.raw[r-1]||r>0&&"\\"===e.raw[r-1]?t:(s+=n.every(e=>e[0]>=r+t.length||r>e[1]),s===c?(o=!0,a):t))
await i.save({raw:r})}catch(u){(0,n.popupAjaxError)(u)}finally{o.forEach(e=>e.classList.remove("readonly")),r.classList.remove("hidden"),r.parentElement.querySelector(".fa-spin").remove()}}})}Object.defineProperty(e,"__esModule",{value:!0}),e.checklistSyntax=l,e.default=void 0
e.default={name:"checklist",initialize(){(0,c.withPluginApi)(e=>function(e){e.container.lookup("service:site-settings").checklist_enabled&&(e.decorateCookedElement(l),e.registerRichEditorExtension(o.default),e.addComposerToolbarPopupMenuOption({menu:"list",name:"list-checklist",icon:"list-check",label:"checklist.composer.checklist",showActiveIcon:!0,active:({state:e})=>e?.inCheckList,action:e=>{e.commands?.toggleChecklist?e.commands.toggleChecklist():e.applyList("- [ ] ","list_item")}}))}(e))}}}),define("discourse/plugins/checklist/lib/discourse-markdown/checklist",["exports"],function(e){"use strict"
Object.defineProperty(e,"__esModule",{value:!0}),e.setup=function(e){e.registerOptions((e,t)=>{e.features.checklist=!!t.checklist_enabled}),e.allowList(["span.chcklst-stroked","span.chcklst-box fa fa-square-o","span.chcklst-box checked fa fa-square-check-o","span.chcklst-box checked permanent fa fa-square-check"]),e.registerPlugin(e=>e.core.ruler.before("text_join","checklist",c))}
const t=/\[( |x)?\]/gi
function n(e,t,n,s){const c=function(e){switch(e){case"x":return"checked fa fa-square-check-o"
case"X":return"checked permanent fa fa-square-check"
default:return"fa fa-square-o"}}(n[1]),o=new s.Token("check_open","span",1)
o.attrs=[["class",`chcklst-box ${c}`]],e.push(o)
const i=new s.Token("check_close","span",-1)
e.push(i)}function s(e,s){let c,o=null,i=0
for(;c=t.exec(e);){if(c.index>i){o=o||[]
const t=new s.Token("text","",0)
t.content=e.slice(i,c.index),o.push(t)}i=c.index+c[0].length,o=o||[],n(o,0,c,s)}if(o&&i<e.length){const t=new s.Token("text","",0)
t.content=e.slice(i),o.push(t)}return o}function c(e){let t,n,c,o,i,r=e.tokens,l=0
for(n=0,c=r.length;n<c;n++)if("inline"===r[n].type)for(o=r[n].children,t=o.length-1;t>=0;t--)if(i=o[t],l+=i.nesting,"text"===i.type&&0===l){const c=s(i.content,e)
c&&(r[n].children=o=e.md.utils.arrayReplaceAt(o,t,c))}}}),define("discourse/plugins/checklist/lib/rich-editor-extension",["exports"],function(e){"use strict"
Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
const t={nodeSpec:{check:{attrs:{checked:{default:!1}},inline:!0,group:"inline",draggable:!0,selectable:!1,toDOM:e=>["span",{class:e.attrs.checked?"chcklst-box checked fa fa-square-check-o":"chcklst-box fa fa-square-o"}],parseDOM:[{tag:"span.chcklst-box",getAttrs:e=>({checked:s(e.className)})}]}},inputRules:[{match:/(^|\s)\[(x? ?)]$/,handler:(e,t,n,s)=>{const c=e.schema.nodes.check.create({checked:"x"===t[2]}),o=e.schema.text(" ")
return e.tr.replaceWith(n+t[1].length,s,[c,o])}}],parse:{check_open:{node:"check",getAttrs:e=>({checked:s(e.attrGet("class"))})},check_close:{noCloseToken:!0,ignore:!0}},serializeNode:{check:(e,t)=>{e.write(t.attrs.checked?"[x]":"[ ]")}},plugins({pmState:{Plugin:e},pmView:{Decoration:t,DecorationSet:n},schema:s,utils:{changedDescendants:c}}){const o=s.nodes.check,i=s.nodes.list_item,r=s.nodes.bullet_list,l=e=>e?.isTextblock&&e.firstChild?.type===o,a=e=>{for(let t=e.depth;t>0;t--)if(e.node(t).type===i)return e.node(t-1)?.type===r?{bulletListDepth:t-1,listItemDepth:t}:null
return null},d=(e,t)=>null!==a(e.resolve(t)),u=(e,t)=>{if(!t.some(e=>e.docChanged))return null
const{selection:n}=e,{$from:c}=n
if(!n.empty)return null
const i=c.parent
if(!i.isTextblock||0!==i.content.size)return null
const r=a(c)
if(!r)return null
const d=c.node(r.bulletListDepth),u=c.index(r.bulletListDepth)
if(0===u)return null
const h=d.child(u-1).firstChild
if(!l(h))return null
if(h.content.size>2){const t=o.create({checked:!1})
return e.insert(c.pos,[t,s.text(" ")]),e.setSelection(n.constructor.near(e.doc.resolve(c.pos+2))),e}return((e,t)=>{const{bulletListDepth:n,listItemDepth:c}=t,{selection:o}=e,{$from:i}=o,r=i.node(n),l=i.index(n),a=r.child(l-1),d=i.before(n)
e.delete(i.before(c),i.after(c))
let u=1
for(let s=0;s<l-1;s++)u+=r.child(s).nodeSize
const h=e.mapping.map(d+u)
e.delete(h,h+a.nodeSize)
const p=e.mapping.map(d),f=e.doc.nodeAt(p)
if(f&&f.childCount>0){const t=p+f.nodeSize
e.insert(t,s.nodes.paragraph.create()),e.setSelection(o.constructor.near(e.doc.resolve(t+1)))}else e.replaceWith(p,p+(f?.nodeSize||0),s.nodes.paragraph.create()),e.setSelection(o.constructor.near(e.doc.resolve(p+1)))
return e})(e,r)}
return[new e({props:{handleClickOn:(e,t,n,s)=>"check"===n.type.name&&(e.dispatch(e.state.tr.setNodeMarkup(s,null,{checked:!n.attrs.checked})),!0),handleKeyDown(e,t){if("Backspace"!==t.key&&"ArrowLeft"!==t.key)return!1
const{state:n,dispatch:s}=e,{selection:c}=n,{$from:o}=c
if(!c.empty||2!==o.parentOffset||!l(o.parent)||!d(n.doc,o.pos))return!1
if("Backspace"===t.key){const e=a(o),t=o.start()
let c=n.tr.delete(t,t+2)
if(e){const t=c.mapping.map(o.before(e.listItemDepth)),n=c.doc.resolve(t)
n.nodeBefore?.type===i&&(c=c.join(t,2))}return s(c),!0}const r=o.before()
return r>0&&(s(n.tr.setSelection(c.constructor.near(n.doc.resolve(r),-1))),!0)}},appendTransaction(e,t,n){if(e.some(e=>1===e.steps.length&&0===e.steps[0].from&&e.steps[0].to===t.doc.content.size))return null
const o=n.tr
return((e,t,n)=>{const o=[]
c(t.doc,n.doc,(e,t)=>{if(!l(e)||!d(n.doc,t))return
const s=e.childCount>1?e.child(1):null
s?.isText&&" "===s.text?.[0]||o.push(t+1+e.firstChild.nodeSize)})
for(let c=o.length-1;c>=0;c--)e.insert(o[c],s.text(" "))})(o,t,n),u(o,e)??(e=>{const{doc:t,selection:n}=e,{$from:s}=n
if(!n.empty)return null
const c=s.parent
if(!l(c)||!d(t,s.pos))return null
const o=c.firstChild.nodeSize,i=c.childCount>1?c.child(1):null,r=i?.isText&&" "===i.text?.[0]?o+1:o
return s.parentOffset<r?(e.setSelection(n.constructor.near(t.resolve(s.start()+r))),e):null})(o)??(o.docChanged?o:null)}}),new e({props:{decorations(e){const s=[]
return e.doc.descendants((e,n,c)=>{e.type===i&&c?.type===r&&l(e.firstChild)&&s.push(t.node(n,n+e.nodeSize,{class:"has-checkbox"}))}),n.create(e.doc,s)}}})]},commands:({schema:e,pmSchemaList:t})=>{const n=e.nodes.check,s=e.nodes.bullet_list,c=e.nodes.ordered_list,o=e.nodes.list_item,i=e=>{const t=e.firstChild
return t?.isTextblock&&t.firstChild?.type===n},r=e=>{const{$from:t,$to:n}=e.selection
for(let i=t.depth;i>0;i--)if(t.node(i).type===o){const e=t.node(i-1)
if(e?.type===s||e?.type===c)return{listDepth:i-1,listItemDepth:i,listType:e.type,list:e,listStart:t.before(i-1),$from:t,$to:n}}return null},l=(e,t)=>{const{list:n,listStart:s,$from:c,$to:o}=e,i=c.pos===o.pos
n.forEach((e,n)=>{const r=s+1+n,l=r+e.nodeSize;(i?c.pos>=r&&c.pos<=l:!(l<=c.pos||r>=o.pos))&&t(e,r)})},a=e=>{if(!e||e.listType!==s)return!1
let t=!1
return l(e,e=>{i(e)&&(t=!0)}),t},d=(e,t)=>{const n=[]
l(t,(e,t)=>{if(i(e)){const s=e.firstChild,c=s.firstChild.nodeSize,o=s.childCount>1?s.child(1):null,i=o?.isText&&" "===o.text?.[0]
n.push({from:t+2,to:t+2+c+(i?1:0)})}})
let s=e.tr
for(let c=n.length-1;c>=0;c--)s=s.delete(n[c].from,n[c].to)
return s},u=(t,s)=>{const c=[]
l(s,(e,t)=>{!i(e)&&e.firstChild?.isTextblock&&c.push(t+2)})
let o=t.tr,r=0
for(const i of c){const t=n.create({checked:!1}),s=e.text(" ")
o=o.insert(i+r,[t,s]),r+=t.nodeSize+s.nodeSize}return o}
return{toggleBulletList:()=>(e,t)=>{const n=r(e)
return!!a(n)&&(t&&t(d(e,n)),!0)},toggleOrderedList:()=>(e,n,s)=>{const i=r(e)
if(!a(i))return!1
if(!n)return!0
const l=t?.liftListItem,u=t?.wrapInList
return!(!l||!u)&&(n(d(e,i)),s&&(l(o)(s.state,n),u(c)(s.state,n)),!0)},toggleChecklist:()=>(e,n,i)=>{const l=r(e),h=t?.wrapInList,p=t?.liftListItem
if(a(l))return n&&p?(n(d(e,l)),i&&p(o)(i.state,n),!0):!!p
if(l?.listType===s)return n&&n(u(e,l)),!0
if(l?.listType===c){if(!n||!p||!h)return!(!p||!h)
if(p(o)(e,n),i){h(s)(i.state,n)
const e=r(i.state)
e&&n(u(i.state,e))}return!0}if(!h)return!1
if(!n)return h(s)(e,void 0)
if(h(s)(e,n),i){const e=r(i.state)
e&&n(u(i.state,e))}return!0}}},state:({schema:e,utils:{inNode:t}},n)=>{const{$from:s}=n.selection
let c=!1
for(let o=s.depth;o>0;o--){const t=s.node(o)
if(t.type===e.nodes.list_item){if(s.node(o-1)?.type===e.nodes.bullet_list){const n=t.firstChild
c=n?.isTextblock&&n.firstChild?.type===e.nodes.check}break}}return{inCheckList:c,inBulletList:!c&&t(n,e.nodes.bullet_list)}}},n=/\bchecked\b/
function s(e){return n.test(e)}e.default=t})

//# sourceMappingURL=checklist-38192a8e.map