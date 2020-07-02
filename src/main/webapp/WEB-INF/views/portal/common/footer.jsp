<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!-- custom script -->
<script>
!function(t,r){if("object"==typeof exports&&"object"==typeof module)module.exports=r();else if("function"==typeof define&&define.amd)define([],r);else{var n=r();for(var e in n)("object"==typeof exports?exports:t)[e]=n[e]}}(window,function(){return function(t){var r={};function n(e){if(r[e])return r[e].exports;var o=r[e]={i:e,l:!1,exports:{}};return t[e].call(o.exports,o,o.exports,n),o.l=!0,o.exports}return n.m=t,n.c=r,n.d=function(t,r,e){n.o(t,r)||Object.defineProperty(t,r,{enumerable:!0,get:e})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,r){if(1&r&&(t=n(t)),8&r)return t;if(4&r&&"object"==typeof t&&t&&t.__esModule)return t;var e=Object.create(null);if(n.r(e),Object.defineProperty(e,"default",{enumerable:!0,value:t}),2&r&&"string"!=typeof t)for(var o in t)n.d(e,o,function(r){return t[r]}.bind(null,o));return e},n.n=function(t){var r=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(r,"a",r),r},n.o=function(t,r){return Object.prototype.hasOwnProperty.call(t,r)},n.p="",n(n.s=90)}([function(t,r,n){(function(r){var n="object",e=function(t){return t&&t.Math==Math&&t};t.exports=e(typeof globalThis==n&&globalThis)||e(typeof window==n&&window)||e(typeof self==n&&self)||e(typeof r==n&&r)||Function("return this")()}).call(this,n(53))},function(t,r){t.exports=function(t){try{return!!t()}catch(t){return!0}}},function(t,r,n){var e=n(1);t.exports=!e(function(){return 7!=Object.defineProperty({},"a",{get:function(){return 7}}).a})},function(t,r,n){var e=n(6);t.exports=function(t){if(!e(t))throw TypeError(String(t)+" is not an object");return t}},function(t,r){var n={}.hasOwnProperty;t.exports=function(t,r){return n.call(t,r)}},function(t,r,n){var e=n(2),o=n(31),i=n(3),u=n(15),a=Object.defineProperty;r.f=e?a:function(t,r,n){if(i(t),r=u(r,!0),i(n),o)try{return a(t,r,n)}catch(t){}if("get"in n||"set"in n)throw TypeError("Accessors not supported");return"value"in n&&(t[r]=n.value),t}},function(t,r){t.exports=function(t){return"object"==typeof t?null!==t:"function"==typeof t}},function(t,r,n){var e=n(0),o=n(16),i=n(25),u=n(42),a=e.Symbol,c=o("wks");t.exports=function(t){return c[t]||(c[t]=u&&a[t]||(u?a:i)("Symbol."+t))}},function(t,r,n){var e=n(30),o=n(12);t.exports=function(t){return e(o(t))}},function(t,r,n){var e=n(2),o=n(5),i=n(17);t.exports=e?function(t,r,n){return o.f(t,r,i(1,n))}:function(t,r,n){return t[r]=n,t}},function(t,r,n){var e=n(0),o=n(11).f,i=n(9),u=n(13),a=n(23),c=n(55),f=n(41);t.exports=function(t,r){var n,s,l,p,v,h=t.target,y=t.global,g=t.stat;if(n=y?e:g?e[h]||a(h,{}):(e[h]||{}).prototype)for(s in r){if(p=r[s],l=t.noTargetGet?(v=o(n,s))&&v.value:n[s],!f(y?s:h+(g?".":"#")+s,t.forced)&&void 0!==l){if(typeof p==typeof l)continue;c(p,l)}(t.sham||l&&l.sham)&&i(p,"sham",!0),u(n,s,p,t)}}},function(t,r,n){var e=n(2),o=n(29),i=n(17),u=n(8),a=n(15),c=n(4),f=n(31),s=Object.getOwnPropertyDescriptor;r.f=e?s:function(t,r){if(t=u(t),r=a(r,!0),f)try{return s(t,r)}catch(t){}if(c(t,r))return i(!o.f.call(t,r),t[r])}},function(t,r){t.exports=function(t){if(null==t)throw TypeError("Can't call method on "+t);return t}},function(t,r,n){var e=n(0),o=n(16),i=n(9),u=n(4),a=n(23),c=n(34),f=n(35),s=f.get,l=f.enforce,p=String(c).split("toString");o("inspectSource",function(t){return c.call(t)}),(t.exports=function(t,r,n,o){var c=!!o&&!!o.unsafe,f=!!o&&!!o.enumerable,s=!!o&&!!o.noTargetGet;"function"==typeof n&&("string"!=typeof r||u(n,"name")||i(n,"name",r),l(n).source=p.join("string"==typeof r?r:"")),t!==e?(c?!s&&t[r]&&(f=!0):delete t[r],f?t[r]=n:i(t,r,n)):f?t[r]=n:a(r,n)})(Function.prototype,"toString",function(){return"function"==typeof this&&s(this).source||c.call(this)})},function(t,r){var n={}.toString;t.exports=function(t){return n.call(t).slice(8,-1)}},function(t,r,n){var e=n(6);t.exports=function(t,r){if(!e(t))return t;var n,o;if(r&&"function"==typeof(n=t.toString)&&!e(o=n.call(t)))return o;if("function"==typeof(n=t.valueOf)&&!e(o=n.call(t)))return o;if(!r&&"function"==typeof(n=t.toString)&&!e(o=n.call(t)))return o;throw TypeError("Can't convert object to primitive value")}},function(t,r,n){var e=n(0),o=n(23),i=n(33),u=e["__core-js_shared__"]||o("__core-js_shared__",{});(t.exports=function(t,r){return u[t]||(u[t]=void 0!==r?r:{})})("versions",[]).push({version:"3.1.3",mode:i?"pure":"global",copyright:"© 2019 Denis Pushkarev (zloirock.ru)"})},function(t,r){t.exports=function(t,r){return{enumerable:!(1&t),configurable:!(2&t),writable:!(4&t),value:r}}},function(t,r){t.exports={}},function(t,r,n){var e=n(39),o=n(26).concat("length","prototype");r.f=Object.getOwnPropertyNames||function(t){return e(t,o)}},function(t,r,n){var e=n(21),o=Math.min;t.exports=function(t){return t>0?o(e(t),9007199254740991):0}},function(t,r){var n=Math.ceil,e=Math.floor;t.exports=function(t){return isNaN(t=+t)?0:(t>0?e:n)(t)}},function(t,r,n){var e=n(12);t.exports=function(t){return Object(e(t))}},function(t,r,n){var e=n(0),o=n(9);t.exports=function(t,r){try{o(e,t,r)}catch(n){e[t]=r}return r}},function(t,r,n){var e=n(16),o=n(25),i=e("keys");t.exports=function(t){return i[t]||(i[t]=o(t))}},function(t,r){var n=0,e=Math.random();t.exports=function(t){return"Symbol("+String(void 0===t?"":t)+")_"+(++n+e).toString(36)}},function(t,r){t.exports=["constructor","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","toLocaleString","toString","valueOf"]},function(t,r,n){var e=n(39),o=n(26);t.exports=Object.keys||function(t){return e(t,o)}},function(t,r,n){var e=n(63),o=n(30),i=n(22),u=n(20),a=n(65),c=[].push,f=function(t){var r=1==t,n=2==t,f=3==t,s=4==t,l=6==t,p=5==t||l;return function(v,h,y,g){for(var d,m,b=i(v),x=o(b),w=e(h,y,3),S=u(x.length),O=0,j=g||a,T=r?j(v,S):n?j(v,0):void 0;S>O;O++)if((p||O in x)&&(m=w(d=x[O],O,b),t))if(r)T[O]=m;else if(m)switch(t){case 3:return!0;case 5:return d;case 6:return O;case 2:c.call(T,d)}else if(s)return!1;return l?-1:f||s?s:T}};t.exports={forEach:f(0),map:f(1),filter:f(2),some:f(3),every:f(4),find:f(5),findIndex:f(6)}},function(t,r,n){"use strict";var e={}.propertyIsEnumerable,o=Object.getOwnPropertyDescriptor,i=o&&!e.call({1:2},1);r.f=i?function(t){var r=o(this,t);return!!r&&r.enumerable}:e},function(t,r,n){var e=n(1),o=n(14),i="".split;t.exports=e(function(){return!Object("z").propertyIsEnumerable(0)})?function(t){return"String"==o(t)?i.call(t,""):Object(t)}:Object},function(t,r,n){var e=n(2),o=n(1),i=n(32);t.exports=!e&&!o(function(){return 7!=Object.defineProperty(i("div"),"a",{get:function(){return 7}}).a})},function(t,r,n){var e=n(0),o=n(6),i=e.document,u=o(i)&&o(i.createElement);t.exports=function(t){return u?i.createElement(t):{}}},function(t,r){t.exports=!1},function(t,r,n){var e=n(16);t.exports=e("native-function-to-string",Function.toString)},function(t,r,n){var e,o,i,u=n(54),a=n(0),c=n(6),f=n(9),s=n(4),l=n(24),p=n(18),v=a.WeakMap;if(u){var h=new v,y=h.get,g=h.has,d=h.set;e=function(t,r){return d.call(h,t,r),r},o=function(t){return y.call(h,t)||{}},i=function(t){return g.call(h,t)}}else{var m=l("state");p[m]=!0,e=function(t,r){return f(t,m,r),r},o=function(t){return s(t,m)?t[m]:{}},i=function(t){return s(t,m)}}t.exports={set:e,get:o,has:i,enforce:function(t){return i(t)?o(t):e(t,{})},getterFor:function(t){return function(r){var n;if(!c(r)||(n=o(r)).type!==t)throw TypeError("Incompatible receiver, "+t+" required");return n}}}},function(t,r,n){var e=n(37),o=n(19),i=n(40),u=n(3);t.exports=e("Reflect","ownKeys")||function(t){var r=o.f(u(t)),n=i.f;return n?r.concat(n(t)):r}},function(t,r,n){var e=n(38),o=n(0),i=function(t){return"function"==typeof t?t:void 0};t.exports=function(t,r){return arguments.length<2?i(e[t])||i(o[t]):e[t]&&e[t][r]||o[t]&&o[t][r]}},function(t,r,n){t.exports=n(0)},function(t,r,n){var e=n(4),o=n(8),i=n(56).indexOf,u=n(18);t.exports=function(t,r){var n,a=o(t),c=0,f=[];for(n in a)!e(u,n)&&e(a,n)&&f.push(n);for(;r.length>c;)e(a,n=r[c++])&&(~i(f,n)||f.push(n));return f}},function(t,r){r.f=Object.getOwnPropertySymbols},function(t,r,n){var e=n(1),o=/#|\.prototype\./,i=function(t,r){var n=a[u(t)];return n==f||n!=c&&("function"==typeof r?e(r):!!r)},u=i.normalize=function(t){return String(t).replace(o,".").toLowerCase()},a=i.data={},c=i.NATIVE="N",f=i.POLYFILL="P";t.exports=i},function(t,r,n){var e=n(1);t.exports=!!Object.getOwnPropertySymbols&&!e(function(){return!String(Symbol())})},function(t,r,n){var e=n(14);t.exports=Array.isArray||function(t){return"Array"==e(t)}},function(t,r,n){var e=n(3),o=n(58),i=n(26),u=n(18),a=n(59),c=n(32),f=n(24)("IE_PROTO"),s=function(){},l=function(){var t,r=c("iframe"),n=i.length;for(r.style.display="none",a.appendChild(r),r.src=String("javascript:"),(t=r.contentWindow.document).open(),t.write("<script>document.F=Object<\/script>"),t.close(),l=t.F;n--;)delete l.prototype[i[n]];return l()};t.exports=Object.create||function(t,r){var n;return null!==t?(s.prototype=e(t),n=new s,s.prototype=null,n[f]=t):n=l(),void 0===r?n:o(n,r)},u[f]=!0},function(t,r,n){r.f=n(7)},function(t,r,n){var e=n(2),o=n(5).f,i=Function.prototype,u=i.toString,a=/^\s*function ([^ (]*)/;!e||"name"in i||o(i,"name",{configurable:!0,get:function(){try{return u.call(this).match(a)[1]}catch(t){return""}}})},function(t,r,n){"use strict";var e=n(9),o=n(13),i=n(1),u=n(7),a=n(48),c=u("species"),f=!i(function(){var t=/./;return t.exec=function(){var t=[];return t.groups={a:"7"},t},"7"!=="".replace(t,"$<a>")}),s=!i(function(){var t=/(?:)/,r=t.exec;t.exec=function(){return r.apply(this,arguments)};var n="ab".split(t);return 2!==n.length||"a"!==n[0]||"b"!==n[1]});t.exports=function(t,r,n,l){var p=u(t),v=!i(function(){var r={};return r[p]=function(){return 7},7!=""[t](r)}),h=v&&!i(function(){var r=!1,n=/a/;return n.exec=function(){return r=!0,null},"split"===t&&(n.constructor={},n.constructor[c]=function(){return n}),n[p](""),!r});if(!v||!h||"replace"===t&&!f||"split"===t&&!s){var y=/./[p],g=n(p,""[t],function(t,r,n,e,o){return r.exec===a?v&&!o?{done:!0,value:y.call(r,n,e)}:{done:!0,value:t.call(n,r,e)}:{done:!1}}),d=g[0],m=g[1];o(String.prototype,t,d),o(RegExp.prototype,p,2==r?function(t,r){return m.call(t,this,r)}:function(t){return m.call(t,this)}),l&&e(RegExp.prototype[p],"sham",!0)}}},function(t,r,n){"use strict";var e,o,i=n(49),u=RegExp.prototype.exec,a=String.prototype.replace,c=u,f=(e=/a/,o=/b*/g,u.call(e,"a"),u.call(o,"a"),0!==e.lastIndex||0!==o.lastIndex),s=void 0!==/()??/.exec("")[1];(f||s)&&(c=function(t){var r,n,e,o,c=this;return s&&(n=new RegExp("^"+c.source+"$(?!\\s)",i.call(c))),f&&(r=c.lastIndex),e=u.call(c,t),f&&e&&(c.lastIndex=c.global?e.index+e[0].length:r),s&&e&&e.length>1&&a.call(e[0],n,function(){for(o=1;o<arguments.length-2;o++)void 0===arguments[o]&&(e[o]=void 0)}),e}),t.exports=c},function(t,r,n){"use strict";var e=n(3);t.exports=function(){var t=e(this),r="";return t.global&&(r+="g"),t.ignoreCase&&(r+="i"),t.multiline&&(r+="m"),t.dotAll&&(r+="s"),t.unicode&&(r+="u"),t.sticky&&(r+="y"),r}},function(t,r,n){"use strict";var e=n(77).charAt;t.exports=function(t,r,n){return r+(n?e(t,r).length:1)}},function(t,r,n){var e=n(14),o=n(48);t.exports=function(t,r){var n=t.exec;if("function"==typeof n){var i=n.call(t,r);if("object"!=typeof i)throw TypeError("RegExp exec method returned something other than an Object or null");return i}if("RegExp"!==e(t))throw TypeError("RegExp#exec called on incompatible receiver");return o.call(t,r)}},function(t,r,n){"use strict";var e=n(10),o=n(0),i=n(33),u=n(2),a=n(42),c=n(1),f=n(4),s=n(43),l=n(6),p=n(3),v=n(22),h=n(8),y=n(15),g=n(17),d=n(44),m=n(27),b=n(19),x=n(60),w=n(40),S=n(11),O=n(5),j=n(29),T=n(9),E=n(13),M=n(16),P=n(24),N=n(18),I=n(25),_=n(7),A=n(45),L=n(61),k=n(62),D=n(35),F=n(28).forEach,R=P("hidden"),C=_("toPrimitive"),V=D.set,G=D.getterFor("Symbol"),$=Object.prototype,q=o.Symbol,z=o.JSON,U=z&&z.stringify,H=S.f,W=O.f,Y=x.f,B=j.f,J=M("symbols"),X=M("op-symbols"),K=M("string-to-symbol-registry"),Q=M("symbol-to-string-registry"),Z=M("wks"),tt=o.QObject,rt=!tt||!tt.prototype||!tt.prototype.findChild,nt=u&&c(function(){return 7!=d(W({},"a",{get:function(){return W(this,"a",{value:7}).a}})).a})?function(t,r,n){var e=H($,r);e&&delete $[r],W(t,r,n),e&&t!==$&&W($,r,e)}:W,et=function(t,r){var n=J[t]=d(q.prototype);return V(n,{type:"Symbol",tag:t,description:r}),u||(n.description=r),n},ot=a&&"symbol"==typeof q.iterator?function(t){return"symbol"==typeof t}:function(t){return Object(t)instanceof q},it=function(t,r,n){t===$&&it(X,r,n),p(t);var e=y(r,!0);return p(n),f(J,e)?(n.enumerable?(f(t,R)&&t[R][e]&&(t[R][e]=!1),n=d(n,{enumerable:g(0,!1)})):(f(t,R)||W(t,R,g(1,{})),t[R][e]=!0),nt(t,e,n)):W(t,e,n)},ut=function(t,r){p(t);var n=h(r),e=m(n).concat(st(n));return F(e,function(r){u&&!at.call(n,r)||it(t,r,n[r])}),t},at=function(t){var r=y(t,!0),n=B.call(this,r);return!(this===$&&f(J,r)&&!f(X,r))&&(!(n||!f(this,r)||!f(J,r)||f(this,R)&&this[R][r])||n)},ct=function(t,r){var n=h(t),e=y(r,!0);if(n!==$||!f(J,e)||f(X,e)){var o=H(n,e);return!o||!f(J,e)||f(n,R)&&n[R][e]||(o.enumerable=!0),o}},ft=function(t){var r=Y(h(t)),n=[];return F(r,function(t){f(J,t)||f(N,t)||n.push(t)}),n},st=function(t){var r=t===$,n=Y(r?X:h(t)),e=[];return F(n,function(t){!f(J,t)||r&&!f($,t)||e.push(J[t])}),e};a||(E((q=function(){if(this instanceof q)throw TypeError("Symbol is not a constructor");var t=arguments.length&&void 0!==arguments[0]?String(arguments[0]):void 0,r=I(t),n=function(t){this===$&&n.call(X,t),f(this,R)&&f(this[R],r)&&(this[R][r]=!1),nt(this,r,g(1,t))};return u&&rt&&nt($,r,{configurable:!0,set:n}),et(r,t)}).prototype,"toString",function(){return G(this).tag}),j.f=at,O.f=it,S.f=ct,b.f=x.f=ft,w.f=st,u&&(W(q.prototype,"description",{configurable:!0,get:function(){return G(this).description}}),i||E($,"propertyIsEnumerable",at,{unsafe:!0})),A.f=function(t){return et(_(t),t)}),e({global:!0,wrap:!0,forced:!a,sham:!a},{Symbol:q}),F(m(Z),function(t){L(t)}),e({target:"Symbol",stat:!0,forced:!a},{for:function(t){var r=String(t);if(f(K,r))return K[r];var n=q(r);return K[r]=n,Q[n]=r,n},keyFor:function(t){if(!ot(t))throw TypeError(t+" is not a symbol");if(f(Q,t))return Q[t]},useSetter:function(){rt=!0},useSimple:function(){rt=!1}}),e({target:"Object",stat:!0,forced:!a,sham:!u},{create:function(t,r){return void 0===r?d(t):ut(d(t),r)},defineProperty:it,defineProperties:ut,getOwnPropertyDescriptor:ct}),e({target:"Object",stat:!0,forced:!a},{getOwnPropertyNames:ft,getOwnPropertySymbols:st}),e({target:"Object",stat:!0,forced:c(function(){w.f(1)})},{getOwnPropertySymbols:function(t){return w.f(v(t))}}),z&&e({target:"JSON",stat:!0,forced:!a||c(function(){var t=q();return"[null]"!=U([t])||"{}"!=U({a:t})||"{}"!=U(Object(t))})},{stringify:function(t){for(var r,n,e=[t],o=1;arguments.length>o;)e.push(arguments[o++]);if(n=r=e[1],(l(r)||void 0!==t)&&!ot(t))return s(r)||(r=function(t,r){if("function"==typeof n&&(r=n.call(this,t,r)),!ot(r))return r}),e[1]=r,U.apply(z,e)}}),q.prototype[C]||T(q.prototype,C,q.prototype.valueOf),k(q,"Symbol"),N[R]=!0},function(t,r){var n;n=function(){return this}();try{n=n||new Function("return this")()}catch(t){"object"==typeof window&&(n=window)}t.exports=n},function(t,r,n){var e=n(0),o=n(34),i=e.WeakMap;t.exports="function"==typeof i&&/native code/.test(o.call(i))},function(t,r,n){var e=n(4),o=n(36),i=n(11),u=n(5);t.exports=function(t,r){for(var n=o(r),a=u.f,c=i.f,f=0;f<n.length;f++){var s=n[f];e(t,s)||a(t,s,c(r,s))}}},function(t,r,n){var e=n(8),o=n(20),i=n(57),u=function(t){return function(r,n,u){var a,c=e(r),f=o(c.length),s=i(u,f);if(t&&n!=n){for(;f>s;)if((a=c[s++])!=a)return!0}else for(;f>s;s++)if((t||s in c)&&c[s]===n)return t||s||0;return!t&&-1}};t.exports={includes:u(!0),indexOf:u(!1)}},function(t,r,n){var e=n(21),o=Math.max,i=Math.min;t.exports=function(t,r){var n=e(t);return n<0?o(n+r,0):i(n,r)}},function(t,r,n){var e=n(2),o=n(5),i=n(3),u=n(27);t.exports=e?Object.defineProperties:function(t,r){i(t);for(var n,e=u(r),a=e.length,c=0;a>c;)o.f(t,n=e[c++],r[n]);return t}},function(t,r,n){var e=n(37);t.exports=e("document","documentElement")},function(t,r,n){var e=n(8),o=n(19).f,i={}.toString,u="object"==typeof window&&window&&Object.getOwnPropertyNames?Object.getOwnPropertyNames(window):[];t.exports.f=function(t){return u&&"[object Window]"==i.call(t)?function(t){try{return o(t)}catch(t){return u.slice()}}(t):o(e(t))}},function(t,r,n){var e=n(38),o=n(4),i=n(45),u=n(5).f;t.exports=function(t){var r=e.Symbol||(e.Symbol={});o(r,t)||u(r,t,{value:i.f(t)})}},function(t,r,n){var e=n(5).f,o=n(4),i=n(7)("toStringTag");t.exports=function(t,r,n){t&&!o(t=n?t:t.prototype,i)&&e(t,i,{configurable:!0,value:r})}},function(t,r,n){var e=n(64);t.exports=function(t,r,n){if(e(t),void 0===r)return t;switch(n){case 0:return function(){return t.call(r)};case 1:return function(n){return t.call(r,n)};case 2:return function(n,e){return t.call(r,n,e)};case 3:return function(n,e,o){return t.call(r,n,e,o)}}return function(){return t.apply(r,arguments)}}},function(t,r){t.exports=function(t){if("function"!=typeof t)throw TypeError(String(t)+" is not a function");return t}},function(t,r,n){var e=n(6),o=n(43),i=n(7)("species");t.exports=function(t,r){var n;return o(t)&&("function"!=typeof(n=t.constructor)||n!==Array&&!o(n.prototype)?e(n)&&null===(n=n[i])&&(n=void 0):n=void 0),new(void 0===n?Array:n)(0===r?0:r)}},function(t,r,n){"use strict";var e=n(10),o=n(28).filter;e({target:"Array",proto:!0,forced:!n(67)("filter")},{filter:function(t){return o(this,t,arguments.length>1?arguments[1]:void 0)}})},function(t,r,n){var e=n(1),o=n(7)("species");t.exports=function(t){return!e(function(){var r=[];return(r.constructor={})[o]=function(){return{foo:1}},1!==r[t](Boolean).foo})}},function(t,r,n){var e=n(10),o=n(1),i=n(8),u=n(11).f,a=n(2),c=o(function(){u(1)});e({target:"Object",stat:!0,forced:!a||c,sham:!a},{getOwnPropertyDescriptor:function(t,r){return u(i(t),r)}})},function(t,r,n){var e=n(10),o=n(2),i=n(36),u=n(8),a=n(11),c=n(70);e({target:"Object",stat:!0,sham:!o},{getOwnPropertyDescriptors:function(t){for(var r,n,e=u(t),o=a.f,f=i(e),s={},l=0;f.length>l;)void 0!==(n=o(e,r=f[l++]))&&c(s,r,n);return s}})},function(t,r,n){"use strict";var e=n(15),o=n(5),i=n(17);t.exports=function(t,r,n){var u=e(r);u in t?o.f(t,u,i(0,n)):t[u]=n}},function(t,r,n){var e=n(10),o=n(22),i=n(27);e({target:"Object",stat:!0,forced:n(1)(function(){i(1)})},{keys:function(t){return i(o(t))}})},function(t,r,n){var e=n(0),o=n(73),i=n(74),u=n(9);for(var a in o){var c=e[a],f=c&&c.prototype;if(f&&f.forEach!==i)try{u(f,"forEach",i)}catch(t){f.forEach=i}}},function(t,r){t.exports={CSSRuleList:0,CSSStyleDeclaration:0,CSSValueList:0,ClientRectList:0,DOMRectList:0,DOMStringList:0,DOMTokenList:1,DataTransferItemList:0,FileList:0,HTMLAllCollection:0,HTMLCollection:0,HTMLFormElement:0,HTMLSelectElement:0,MediaList:0,MimeTypeArray:0,NamedNodeMap:0,NodeList:1,PaintRequestList:0,Plugin:0,PluginArray:0,SVGLengthList:0,SVGNumberList:0,SVGPathSegList:0,SVGPointList:0,SVGStringList:0,SVGTransformList:0,SourceBufferList:0,StyleSheetList:0,TextTrackCueList:0,TextTrackList:0,TouchList:0}},function(t,r,n){"use strict";var e=n(28).forEach,o=n(75);t.exports=o("forEach")?function(t){return e(this,t,arguments.length>1?arguments[1]:void 0)}:[].forEach},function(t,r,n){"use strict";var e=n(1);t.exports=function(t,r){var n=[][t];return!n||!e(function(){n.call(null,r||function(){throw 1},1)})}},function(t,r,n){"use strict";var e=n(47),o=n(3),i=n(20),u=n(12),a=n(50),c=n(51);e("match",1,function(t,r,n){return[function(r){var n=u(this),e=null==r?void 0:r[t];return void 0!==e?e.call(r,n):new RegExp(r)[t](String(n))},function(t){var e=n(r,t,this);if(e.done)return e.value;var u=o(t),f=String(this);if(!u.global)return c(u,f);var s=u.unicode;u.lastIndex=0;for(var l,p=[],v=0;null!==(l=c(u,f));){var h=String(l[0]);p[v]=h,""===h&&(u.lastIndex=a(f,i(u.lastIndex),s)),v++}return 0===v?null:p}]})},function(t,r,n){var e=n(21),o=n(12),i=function(t){return function(r,n){var i,u,a=String(o(r)),c=e(n),f=a.length;return c<0||c>=f?t?"":void 0:(i=a.charCodeAt(c))<55296||i>56319||c+1===f||(u=a.charCodeAt(c+1))<56320||u>57343?t?a.charAt(c):i:t?a.slice(c,c+2):u-56320+(i-55296<<10)+65536}};t.exports={codeAt:i(!1),charAt:i(!0)}},function(t,r,n){"use strict";var e=n(2),o=n(0),i=n(41),u=n(13),a=n(4),c=n(14),f=n(79),s=n(15),l=n(1),p=n(44),v=n(19).f,h=n(11).f,y=n(5).f,g=n(82).trim,d=o.Number,m=d.prototype,b="Number"==c(p(m)),x=function(t){var r,n,e,o,i,u,a,c,f=s(t,!1);if("string"==typeof f&&f.length>2)if(43===(r=(f=g(f)).charCodeAt(0))||45===r){if(88===(n=f.charCodeAt(2))||120===n)return NaN}else if(48===r){switch(f.charCodeAt(1)){case 66:case 98:e=2,o=49;break;case 79:case 111:e=8,o=55;break;default:return+f}for(u=(i=f.slice(2)).length,a=0;a<u;a++)if((c=i.charCodeAt(a))<48||c>o)return NaN;return parseInt(i,e)}return+f};if(i("Number",!d(" 0o1")||!d("0b1")||d("+0x1"))){for(var w,S=function(t){var r=arguments.length<1?0:t,n=this;return n instanceof S&&(b?l(function(){m.valueOf.call(n)}):"Number"!=c(n))?f(new d(x(r)),n,S):x(r)},O=e?v(d):"MAX_VALUE,MIN_VALUE,NaN,NEGATIVE_INFINITY,POSITIVE_INFINITY,EPSILON,isFinite,isInteger,isNaN,isSafeInteger,MAX_SAFE_INTEGER,MIN_SAFE_INTEGER,parseFloat,parseInt,isInteger".split(","),j=0;O.length>j;j++)a(d,w=O[j])&&!a(S,w)&&y(S,w,h(d,w));S.prototype=m,m.constructor=S,u(o,"Number",S)}},function(t,r,n){var e=n(6),o=n(80);t.exports=function(t,r,n){var i,u;return o&&"function"==typeof(i=r.constructor)&&i!==n&&e(u=i.prototype)&&u!==n.prototype&&o(t,u),t}},function(t,r,n){var e=n(3),o=n(81);t.exports=Object.setPrototypeOf||("__proto__"in{}?function(){var t,r=!1,n={};try{(t=Object.getOwnPropertyDescriptor(Object.prototype,"__proto__").set).call(n,[]),r=n instanceof Array}catch(t){}return function(n,i){return e(n),o(i),r?t.call(n,i):n.__proto__=i,n}}():void 0)},function(t,r,n){var e=n(6);t.exports=function(t){if(!e(t)&&null!==t)throw TypeError("Can't set "+String(t)+" as a prototype");return t}},function(t,r,n){var e=n(12),o="["+n(83)+"]",i=RegExp("^"+o+o+"*"),u=RegExp(o+o+"*$"),a=function(t){return function(r){var n=String(e(r));return 1&t&&(n=n.replace(i,"")),2&t&&(n=n.replace(u,"")),n}};t.exports={start:a(1),end:a(2),trim:a(3)}},function(t,r){t.exports="\t\n\v\f\r                　\u2028\u2029\ufeff"},function(t,r,n){n(10)({target:"Number",stat:!0},{isNaN:function(t){return t!=t}})},function(t,r,n){var e=n(13),o=n(86),i=Object.prototype;o!==i.toString&&e(i,"toString",o,{unsafe:!0})},function(t,r,n){"use strict";var e=n(87),o={};o[n(7)("toStringTag")]="z",t.exports="[object z]"!==String(o)?function(){return"[object "+e(this)+"]"}:o.toString},function(t,r,n){var e=n(14),o=n(7)("toStringTag"),i="Arguments"==e(function(){return arguments}());t.exports=function(t){var r,n,u;return void 0===t?"Undefined":null===t?"Null":"string"==typeof(n=function(t,r){try{return t[r]}catch(t){}}(r=Object(t),o))?n:i?e(r):"Object"==(u=e(r))&&"function"==typeof r.callee?"Arguments":u}},function(t,r,n){"use strict";var e=n(13),o=n(3),i=n(1),u=n(49),a=RegExp.prototype,c=a.toString,f=i(function(){return"/a/b"!=c.call({source:"a",flags:"b"})}),s="toString"!=c.name;(f||s)&&e(RegExp.prototype,"toString",function(){var t=o(this),r=String(t.source),n=t.flags;return"/"+r+"/"+String(void 0===n&&t instanceof RegExp&&!("flags"in a)?u.call(t):n)},{unsafe:!0})},function(t,r,n){"use strict";var e=n(47),o=n(3),i=n(22),u=n(20),a=n(21),c=n(12),f=n(50),s=n(51),l=Math.max,p=Math.min,v=Math.floor,h=/\$([$&'`]|\d\d?|<[^>]*>)/g,y=/\$([$&'`]|\d\d?)/g;e("replace",2,function(t,r,n){return[function(n,e){var o=c(this),i=null==n?void 0:n[t];return void 0!==i?i.call(n,o,e):r.call(String(o),n,e)},function(t,i){var c=n(r,t,this,i);if(c.done)return c.value;var v=o(t),h=String(this),y="function"==typeof i;y||(i=String(i));var g=v.global;if(g){var d=v.unicode;v.lastIndex=0}for(var m=[];;){var b=s(v,h);if(null===b)break;if(m.push(b),!g)break;""===String(b[0])&&(v.lastIndex=f(h,u(v.lastIndex),d))}for(var x,w="",S=0,O=0;O<m.length;O++){b=m[O];for(var j=String(b[0]),T=l(p(a(b.index),h.length),0),E=[],M=1;M<b.length;M++)E.push(void 0===(x=b[M])?x:String(x));var P=b.groups;if(y){var N=[j].concat(E,T,h);void 0!==P&&N.push(P);var I=String(i.apply(void 0,N))}else I=e(j,h,T,E,P,i);T>=S&&(w+=h.slice(S,T)+I,S=T+j.length)}return w+h.slice(S)}];function e(t,n,e,o,u,a){var c=e+t.length,f=o.length,s=y;return void 0!==u&&(u=i(u),s=h),r.call(a,s,function(r,i){var a;switch(i.charAt(0)){case"$":return"$";case"&":return t;case"`":return n.slice(0,e);case"'":return n.slice(c);case"<":a=u[i.slice(1,-1)];break;default:var s=+i;if(0===s)return r;if(s>f){var l=v(s/10);return 0===l?r:l<=f?void 0===o[l-1]?i.charAt(1):o[l-1]+i.charAt(1):r}a=o[s-1]}return void 0===a?"":a})}})},function(t,r,n){"use strict";n.r(r);n(52),n(66),n(46),n(68),n(69),n(71),n(72);var e={lang:"en",date:"2019-7-14 10:30:30 0"},o=(n(76),n(78),n(84),n(85),n(88),Object.prototype.toString);function i(t){return"[object Date]"===o.call(t)&&!Number.isNaN(t.getTime())}n(89);var u={en:{year:{previous:"last year",current:"this year",next:"next year",past:"{0} years ago",future:"in {0} years"},quarter:{previous:"last quarter",current:"this quarter",next:"next quarter",past:"{0} quarters ago",future:"in {0} quarters"},month:{previous:"last month",current:"this month",next:"next month",past:"{0} months ago",future:"in {0} months"},week:{previous:"last week",current:"this week",next:"next week",past:"{0} weeks ago",future:"in {0} weeks"},day:{previous:"yesterday",current:"today",next:"tomorrow",past:"{0} days ago",future:"in {0} days"},hour:{previous:"{0} hour ago",current:"this hour",next:"in {0} hour",past:"{0} hours ago",future:"in {0} hours"},minute:{previous:"{0} minute ago",current:"this minute",next:"in {0} minute",past:"{0} minutes ago",future:"in {0} minutes"},second:{previous:"{0} second ago",current:"now",next:"in {0} second",past:"{0} seconds ago",future:"in {0} seconds"}},zh:{year:{previous:"去年",current:"今年",next:"明年",past:"{0}年前",future:"{0}年后"},quarter:{previous:"上季度",current:"本季度",next:"下季度",past:"{0}个季度前",future:"{0}个季度后"},month:{previous:"上个月",current:"本月",next:"下个月",past:"{0}个月前",future:"{0}个月后"},week:{previous:"上周",current:"本周",next:"下周",past:"{0}周前",future:"{0}周后"},day:{previous:"昨天",previous2:"前天",current:"今天",next:"明天",next2:"后天",past:"{0}天前",future:"{0}天后"},hour:{previous:"{0}小时前",current:"此时",next:"小时后",past:"{0}小时前",future:"{0}小时后"},minute:{previous:"{0}分钟前",current:"此刻",next:"小时后",past:"{0}秒钟后",future:"{0}分钟后"},second:{previous:"{0}秒钟前",current:"现在",past:"{0}秒钟后",next:"小时后",future:"{0}秒钟后"}}};function a(t,r){for(var n=0;n<r.length;n++){var e=r[n];e.enumerable=e.enumerable||!1,e.configurable=!0,"value"in e&&(e.writable=!0),Object.defineProperty(t,e.key,e)}}var c=function(){function t(r){!function(t,r){if(!(t instanceof r))throw new TypeError("Cannot call a class as a function")}(this,t),this.local=r||"en",this.localData=u[this.local],this.name="Custom.RelativeTimeFormat"}var r,n,e;return r=t,(n=[{key:"format",value:function(t,r){return t>1?"zh"===this.local&&2===t?this.localData[r].next2.replace(/\{0\}/,Math.abs(t)):this.localData[r].future.replace(/\{0\}/,Math.abs(t)):1===t?this.localData[r].next.replace(/\{0\}/,Math.abs(t)):0===t?this.localData[r].current.replace(/\{0\}/,Math.abs(t)):-1===t?this.localData[r].previous.replace(/\{0\}/,Math.abs(t)):"zh"===this.local&&-2===t?this.localData[r].previous2.replace(/\{0\}/,Math.abs(t)):this.localData[r].past.replace(/\{0\}/,Math.abs(t))}}])&&a(r.prototype,n),e&&a(r,e),t}(),f="undefined"!=typeof window;function s(t,r){var n=Object.keys(t);return Object.getOwnPropertySymbols&&n.push.apply(n,Object.getOwnPropertySymbols(t)),r&&(n=n.filter(function(r){return Object.getOwnPropertyDescriptor(t,r).enumerable})),n}function l(t,r,n){return r in t?Object.defineProperty(t,r,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[r]=n,t}function p(t,r){for(var n=0;n<r.length;n++){var e=r[n];e.enumerable=e.enumerable||!1,e.configurable=!0,"value"in e&&(e.writable=!0),Object.defineProperty(t,e.key,e)}}var v=function(){function t(r){!function(t,r){if(!(t instanceof r))throw new TypeError("Cannot call a class as a function")}(this,t),this.options=function(t){for(var r=1;r<arguments.length;r++){var n=null!=arguments[r]?arguments[r]:{};r%2?s(n,!0).forEach(function(r){l(t,r,n[r])}):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):s(n).forEach(function(r){Object.defineProperty(t,r,Object.getOwnPropertyDescriptor(n,r))})}return t}({},e,{},r),this.output="时间都去哪儿了",this.relativeTimeFomatObj=null,this.init(),this.name="relative time"}var r,n,o;return r=t,(n=[{key:"init",value:function(){this.version="1.2.0";var t=this.timeUntil();t&&(this.output=this.timeUntilFromMs(t))}},{key:"formatTime",value:function(t,r){return"Intl"in window&&"RelativeTimeFormat"in window.Intl?this.relativeTimeFomatObj=new Intl.RelativeTimeFormat(this.options.lang,{numeric:"auto"}):this.relativeTimeFomatObj=new c(this.options.lang),this.relativeTimeFomatObj.format(t,r)}},{key:"timeUntilFromMs",value:function(t){var r=Math.round(t/1e3),n=Math.round(r/60),e=Math.round(n/60),o=Math.round(e/24),i=Math.round(o/30),u=Math.round(i/12);return Math.abs(i)>=12?this.formatTime(u,"year"):Math.abs(o)>=30?this.formatTime(i,"month"):Math.abs(e)>=24?this.formatTime(o,"day"):Math.abs(n)>=45?this.formatTime(e,"hour"):Math.abs(r)>=45?this.formatTime(n,"minute"):Math.abs(r)>=10?this.formatTime(r,"second"):this.formatTime(0,"second")}},{key:"timeUntil",value:function(){var t=function(t){if(i(t))return t.getTime();if("string"==typeof t&&t.indexOf("-")){var r=t.match(/^(\d{4})-?(\d{1,2})-?(\d{0,2})[\s]?(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.|\s]?(\d{1,3})?$/),n=new Date(NaN);if(function(t){return null!=t}(e=r)&&"number"==typeof e.length&&"function"!=typeof e&&(n=new Date(r[1],r[2]-1||0,r[3]||1,r[4]||0,r[5]||0,r[6]||0,r[7]||0)),i(n))return n.getTime()}var e;return!!i(new Date(t))&&t}(this.options.date);return!!t&&t-Date.now()}}])&&p(r.prototype,n),o&&p(r,o),t}();f&&(window.console.log("plugin is running browser."),window.RelativeTIime=v);r.default=v}])});

 // modal mask
function addFixed() {
	$(document.body).css({
		overflow: 'hidden',
	});
}

function removeFixed() {
	$(document.body).css({
		overflow: 'auto',
	});
}
/* product add/sub */
function productAdd(el, callback) {
	var parentEl = el.parents('.product-qty');
	var max = parentEl.find('.product-num').data('count') && parseInt(parentEl.find('.product-num').data('count')) || Infinity;
	var curr = parseInt(parentEl.find('.product-num').val());

	curr += 1;
	if (curr > max) {
		curr = max;
		var modal = createModal({
			body: {
				html: '<p>Existing inventory <b>'+ curr + '</b> pieces !</p>'
			},
			autoClose: true,
		});
	}

	parentEl.find('.product-num').val(curr);
	callback && callback(parentEl, curr);
}

function productSub(el, callback) {
	var parentEl = el.parents('.product-qty');
	var curr = parseInt(parentEl.find('.product-num').val());
	curr -= 1;
	if (curr < 1) {
		curr = 1;
		var modal = createModal({
			body: {
				html: '<p>At least one product !</p>'
			},
			autoClose: true
		});
	}

	parentEl.find('.product-num').val(curr);
	callback && callback(parentEl, curr);
}

/* product option */
function getProductOption(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackProductAttributeName/getMlbackProductAttributeNameListByProductId',
		data: JSON.stringify({ "productattrnamePid": productId }),
		dataType: 'json',
		contentType: 'application/json',
		type: "post",
		async: false,
		success: function (data) {
			if (data.code == 100) {
				callback(data.extend.mbackProductAttributeNameResList);
			}
		}
	});
}
function renderProductOptions(data, selectedRadioArr) {
	function createOption(data, value) {
		var optionName = data.productattrnameName;
		var optionValue  = data.productattrnameValues.split(',');
		var optionItem = $('<div class="product-option-item" data-type="'+ optionName +'" data-id="'+ data.productattrnameId +'" />');
		var htmlStr = '<div class="name">'+ optionName +':</div>';

		optionObj[optionName] = optionValue;
		optionIdArr.push(data.productattrnameId);

		htmlStr += '<div class="body">';
		optionValue.forEach(function(item, idx) {
			htmlStr += '<span class="radio'+ (value == item ? ' active' : '') +'" data-text="'+ item +'">'+ item +'</span>';
		});
		htmlStr += '</div>'
		optionItem.html(htmlStr);
		$('.product-options').append(optionItem);
	}
	data.forEach(function(item, idx) {
		createOption(item, selectedRadioArr && selectedRadioArr[idx]);
	});
}

/* product sku-list status=1 */
function getProductSkus(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackProductSku/customerGetMlbackProductSkuListByPId',
		data: JSON.stringify({
			"productskuPid": productId,
			"productskuStatus": 1
		}),
		dataType: 'json',
		contentType: 'application/json',
		type: "post",
		async: false,
		success: function (data) {
			if (data.code == 100) {
				callback(data.extend.mlbackProductSkuResList);
			}
		}
	});
}	
// skus		
function buildResult(items) {
    var paths = getPaths(items);
    for (var i = 0; i < paths.length; i+=1) {
        var curr = paths[i];
        var stock = items[i].productskuStock || 0;
        var arr = curr.split(',')
        var allSets = powerset(arr);

        for (var j = 0; j < allSets.length; j+=1) {
            var subSet = allSets[j].join(',')
            if (mapSet[subSet]) {
                mapSet[subSet].count += stock
            } else {
                mapSet[subSet] = { 'count': stock }
            }
        }
    }
}
function getPaths(items) {
    return items.reduce(function(acc, item) {
        mapItems[item.productskuName] = item
        acc.push(item.productskuName)
        return acc
    }, [])
}
function trimSpliter(str) {
    var reLeft = new RegExp('^,+', 'g');
    var reRight = new RegExp(',+$', 'g');
    var reSpliter = new RegExp(',+', 'g');

    return str.replace(reLeft, '')
        .replace(reRight, '')
        .replace(reSpliter, ',')
}
function getSelectedItem() {
    var selectedItems = [];
    $('.product-option-item').each(function () {
        var $selected = $(this).find('.radio.active');
        if ($selected.length) {
            selectedItems.push($selected.data('text'));
        } else {
            selectedItems.push('');
        }
    })

    return selectedItems
}
function powerset(arr) {
    var ps = [[]];
    for (var i = 0; i < arr.length; i+=1) {
        for (var j = 0, len = ps.length; j < len; j+=1) {
            ps.push(ps[j].concat(arr[i]))
        }
    }
    return ps;
}
function updateProductStatus(selected) {
	var keys = Object.keys(optionObj);
    for (var i = 0, len = keys.length; i < len; i+=1) {
        var key = keys[i];
        var data = optionObj[key];
        var selectArr = selected.slice();

        for (var j = 0; j < data.length; j+=1) {
            var item = data[j];

            /* if (selected[i] == item) continue; */

            selectArr[i] = item;

            var curr = trimSpliter(selectArr.join(','), ',');
            var $item = $('.product-option-item[data-type="' + key + '"]').find('.radio[data-text="' + item + '"]');

            if (mapSet[curr] && mapSet[curr].count) {
                $item.removeClass('disabled');
            } else {
            	 $item.addClass('disabled').removeClass('active');
            }
        }
    }
}
function handleNormalClick(el) {
    el.hasClass('active')
        ? (el.siblings().removeClass('disabled'), el.removeClass('active'))
        : (el.siblings().removeClass('active'), el.addClass('active'))
}
function showResult() {
    var selectedItems = getSelectedItem();
    var selectedKeys = [];

    for (var i = 0; i < selectedItems.length; i+=1) {
        var item = selectedItems[i];
        if (!!item) {
            selectedKeys.push(item);
        }
    }

    updateProductData(selectedKeys);
}

// check add/sub product; add-to-cart/buynow product;
function isCorrectProduct() {
	var optionItems = $('.product-option-item');
	var flag = true;
	// option check
	for (var i = 0, len = optionItems.length; i < len; i += 1) {
		var $optionItem = $(optionItems[i]);
		if (!$optionItem.find('.radio.active').length) {
    		var modal = createModal({
    			body: {
    				html: '<p>Please select a product specifications and options: '+ $optionItem.data('type') + '</p>'
    			},
    			autoClose: true
    		});
    		flag = false;
    		break;
		}
	}
	return flag;
}
// product radio click
$(document.body).on('click', '.radio', function(e) {
	var $this = $(this)

    if (!$this.hasClass('disabled')) {
        handleNormalClick($this);
        updateProductStatus(getSelectedItem());
        showResult();
   	}

	$('.radio').each(function () {
        if (!mapSet[$(this).data('text')] && !$(this).hasClass('active')) {
            $(this).addClass('disabled');
        }
    });
});
/* modal */
$(document.body).on('click', '.modal, .modal-close, .btn-no', function(e) {
    if (e.target == this) {
    	removeFixed();
        $('.modal').remove();
    }
});

function mergeOpts (opts1, opts2) {
    var res = $.extend(true, {}, opts1, opts2);

    $.each(opts2, function (key, value) {
      if ($.isArray(value)) {
        res[key] = value;
      }
    });

    return res;
}

function createModal(option) {
	var opt = mergeOpts({
		header: {
			html: '',
			isShow: true,
		},
		body: {
			html: '',
			isShow: true,
		},
		footer: {
			html: '',
			isShow: false,
		},
		autoClose: false
	}, option);
	var htmlStr = '';
	var timer = null
	var modal = $('<div class="modal">' +
	    '<div class="modal-close">x</div>' +
	    '<div class="modal-container">' +
	    	(opt.header.isShow ? ('<div class="modal-header">' + (opt.header.html ? opt.header.html : '<p>Megalook Tip !</p>') + '</div>') : '') +
	    	('<div class="modal-body">' + opt.body.html + '</div>') +
	    	(opt.footer.isShow
	    			? ('<div class="modal-footer">' + 
	    					(opt.footer.html ? opt.footer.html : '<button class="btn btn-no modal-no"> No </button><button class="btn btn-yes modal-ok"> Yes </button>') +
	    				'</div>')
	    			: '') +
	    '</div>' +
	'</div>');
	var modalLen = $('.modal').length;
	if (modalLen) modal.css('z-index', getComputedStyle($('.modal')[0]).zIndex + modalLen + 1);
	function openTimer() {
		timer = setTimeout(function() {
    		removeModal(modal);
    	}, 1000);
	}
	$(document.body).append(modal);
	setTimeout(function() {
		modal.addClass('active');
	});
    addFixed();
    
    if (opt.autoClose) {
    	openTimer();
	    var modalContainer = modal.find('.modal-container');
	    modalContainer.on('mouseenter', function() {
	    	clearTimeout(timer);
	    });
	    
	    modalContainer.on('mouseleave', function() {
	    	openTimer();
	    });
    }
    
	return modal;
}

function removeModal(modal) {
	modal.remove();
    removeFixed();
}

function mlModalTip(text) {
	var modal = createModal({
		body: {
			html: '<p>'+ text +'</p>'
		},
		autoClose: true
	});
}

function sysModalTip() {
	mlModalTip('Settlement system error, temporarily unable to, please try again later !');
}

function sysModalErrorTip (err) {
	mlModalTip('Error: '+ JSON.stringify(err));
}

function refreshPageModal() {
	mlModalTip('please refresh the page to get again !');
}

function deleteProductSuccessModal() {
	mlModalTip('Successfully deleting  the product !');
}

function deleteProductFailModal() {
	mlModalTip('Failed to delete the product !');
}

function updateProductNumSuccessModal() {
	mlModalTip('Successfully updating the product !');	
}

function updateProductNumFailModal() {
	mlModalTip('Failed to update the product !');
}

// pay loading
function payLoading() {
	var $payLoading = $('<div class="pay-loading"><div class="load-list"><div class="loader-item"></div><div class="loader-item"></div><div class="loader-item"></div></div>');
	$(document.body).append($payLoading);
	addFixed();
}

/* jump link function */
function goToIndex() {
	window.location.href = '${APP_PATH}';
}
function goToCheckout() {
	window.location.href = '${APP_PATH}/MlbackCart/toCheakOut';
}
function goToCartList() {
	window.location.href = '${APP_PATH}/MlbackCart/toCartList';
}
function goToPay() {
	window.location.href = '${APP_PATH }/paypal/mpay';
}
function goTopayInstance() {
	window.location.href = '${APP_PATH}/paypalProDetailExpress/mpay';
}
function goToUserCenter() {
	 window.location.href = "${APP_PATH }/MlfrontUser/toUserCenter";
}

/* pagination */
/* pageNum */
function getPageNum() {
	return storage.getItem('pageNum') || 1
}

function setPageNum(val) {
	storage.setItem('pageNum', val);
}

function makerArray(n) {
	var arr = []
	for (var i = 0; i < n; i++) {
		arr.push(i + 1);
	}
	return arr;
}
function renderTablePagination(data) {
	if (data) {
		$("#table-pagination").empty();
		//构建元素
		var pageUl = $('<ul class="pagination" />'),
			firstPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('first').attr('href', 'javascript:;')),
			prePageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&laquo;')),
			nextPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&raquo;')),
			lastPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('last').attr('href', 'javascript:;')),
			pageCurrentNum = data.pageNum,
			pageNums = data.pages,
			pageArr = [];
		prePageLi.on('click', function () {
			pageCurrentNum > 1 && setPageNum(pageCurrentNum - 1);
		});
		nextPageLi.on('click', function () {
			pageCurrentNum < pageNums && setPageNum(pageCurrentNum + 1);
		});
		if (pageNums > 5) {
			if (pageCurrentNum <= 5) {
				pageArr = [1, 2, 3, 4, 5];
			} else if (pageCurrentNum > pageNums - 5) {
				pageArr = [pageNums - 4, pageNums - 3, pageNums - 2, pageNums - 1, pageNums];
			} else {
				pageArr = [pageCurrentNum - 2, pageCurrentNum - 1, pageCurrentNum, pageCurrentNum + 1, pageCurrentNum + 2];
			}
		} else {
			pageArr = makerArray(pageNums || 1);
		}

		if (data.hasPreviousPage == false) {
			firstPageLi.addClass('disabled');
			prePageLi.addClass('disabled');
		} else {
			//为元素添加点击翻页的事件
			firstPageLi.click(function () {
				setPageNum(1);
			});
			prePageLi.click(function () {
				setPageNum(pageCurrentNum - 1);
			});
		}

		if (data.hasNextPage == false) {
			nextPageLi.addClass('disabled');
			lastPageLi.addClass('disabled');
		} else {
			nextPageLi.click(function () {
				setPageNum(pageCurrentNum + 1);
			});
			lastPageLi.click(function () {
				setPageNum(pageNums);
			});
		}

		pageUl.append(firstPageLi).append(prePageLi);

		$.each(pageArr, function (i, item) {
			var numLi = $('<li class="page-item" />').append($('<a class="page-link" href="javascript:;" />').append(item));
			if (pageCurrentNum == item) {
				numLi.addClass('active');
			}
			numLi.click(function () {
				setPageNum(item);
			});
			pageUl.append(numLi);
		});

		pageUl.append(nextPageLi).append(lastPageLi);

		var navEle = $('<nav aria-label="Page navigation" />').append(pageUl);
		navEle.appendTo('#table-pagination');
	}
}
/* varient */
var timer = null, timeStart = Date.now(), mapSet = {}, mapItems = {}, optionObj = {}, optionIdArr = [], emailPattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
var storage = window.localStorage;
</script>