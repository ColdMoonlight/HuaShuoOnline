<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<script>!function(t,e){if("object"==typeof exports&&"object"==typeof module)module.exports=e();else if("function"==typeof define&&define.amd)define([],e);else{var n=e();for(var r in n)("object"==typeof exports?exports:t)[r]=n[r]}}(window,function(){return function(t){var e={};function n(r){if(e[r])return e[r].exports;var o=e[r]={i:r,l:!1,exports:{}};return t[r].call(o.exports,o,o.exports,n),o.l=!0,o.exports}return n.m=t,n.c=e,n.d=function(t,e,r){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:r})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var r=Object.create(null);if(n.r(r),Object.defineProperty(r,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var o in t)n.d(r,o,function(e){return t[e]}.bind(null,o));return r},n.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s=77)}([function(t,e){t.exports=function(t){try{return!!t()}catch(t){return!0}}},function(t,e,n){var r=n(2),o=n(19),i=n(30),u=n(56),c=r.Symbol,s=o("wks");t.exports=function(t){return s[t]||(s[t]=u&&c[t]||(u?c:i)("Symbol."+t))}},function(t,e,n){(function(e){var n="object",r=function(t){return t&&t.Math==Math&&t};t.exports=r(typeof globalThis==n&&globalThis)||r(typeof window==n&&window)||r(typeof self==n&&self)||r(typeof e==n&&e)||Function("return this")()}).call(this,n(78))},function(t,e,n){var r=n(2),o=n(14).f,i=n(8),u=n(12),c=n(29),s=n(50),a=n(33);t.exports=function(t,e){var n,f,l,p,v,h=t.target,d=t.global,g=t.stat;if(n=d?r:g?r[h]||c(h,{}):(r[h]||{}).prototype)for(f in e){if(p=e[f],l=t.noTargetGet?(v=o(n,f))&&v.value:n[f],!a(d?f:h+(g?".":"#")+f,t.forced)&&void 0!==l){if(typeof p==typeof l)continue;s(p,l)}(t.sham||l&&l.sham)&&i(p,"sham",!0),u(n,f,p,t)}}},function(t,e,n){var r=n(0);t.exports=!r(function(){return 7!=Object.defineProperty({},"a",{get:function(){return 7}}).a})},function(t,e){t.exports=function(t){return"object"==typeof t?null!==t:"function"==typeof t}},function(t,e){var n={}.hasOwnProperty;t.exports=function(t,e){return n.call(t,e)}},function(t,e,n){var r=n(5);t.exports=function(t){if(!r(t))throw TypeError(String(t)+" is not an object");return t}},function(t,e,n){var r=n(4),o=n(9),i=n(17);t.exports=r?function(t,e,n){return o.f(t,e,i(1,n))}:function(t,e,n){return t[e]=n,t}},function(t,e,n){var r=n(4),o=n(47),i=n(7),u=n(18),c=Object.defineProperty;e.f=r?c:function(t,e,n){if(i(t),e=u(e,!0),i(n),o)try{return c(t,e,n)}catch(t){}if("get"in n||"set"in n)throw TypeError("Accessors not supported");return"value"in n&&(t[e]=n.value),t}},function(t,e,n){var r=n(28),o=n(11);t.exports=function(t){return r(o(t))}},function(t,e){t.exports=function(t){if(null==t)throw TypeError("Can't call method on "+t);return t}},function(t,e,n){var r=n(2),o=n(19),i=n(8),u=n(6),c=n(29),s=n(49),a=n(22),f=a.get,l=a.enforce,p=String(s).split("toString");o("inspectSource",function(t){return s.call(t)}),(t.exports=function(t,e,n,o){var s=!!o&&!!o.unsafe,a=!!o&&!!o.enumerable,f=!!o&&!!o.noTargetGet;"function"==typeof n&&("string"!=typeof e||u(n,"name")||i(n,"name",e),l(n).source=p.join("string"==typeof e?e:"")),t!==r?(s?!f&&t[e]&&(a=!0):delete t[e],a?t[e]=n:i(t,e,n)):a?t[e]=n:c(e,n)})(Function.prototype,"toString",function(){return"function"==typeof this&&f(this).source||s.call(this)})},function(t,e,n){var r=n(25),o=Math.min;t.exports=function(t){return t>0?o(r(t),9007199254740991):0}},function(t,e,n){var r=n(4),o=n(46),i=n(17),u=n(10),c=n(18),s=n(6),a=n(47),f=Object.getOwnPropertyDescriptor;e.f=r?f:function(t,e){if(t=u(t),e=c(e,!0),a)try{return f(t,e)}catch(t){}if(s(t,e))return i(!o.f.call(t,e),t[e])}},function(t,e){var n={}.toString;t.exports=function(t){return n.call(t).slice(8,-1)}},function(t,e,n){var r=n(11);t.exports=function(t){return Object(r(t))}},function(t,e){t.exports=function(t,e){return{enumerable:!(1&t),configurable:!(2&t),writable:!(4&t),value:e}}},function(t,e,n){var r=n(5);t.exports=function(t,e){if(!r(t))return t;var n,o;if(e&&"function"==typeof(n=t.toString)&&!r(o=n.call(t)))return o;if("function"==typeof(n=t.valueOf)&&!r(o=n.call(t)))return o;if(!e&&"function"==typeof(n=t.toString)&&!r(o=n.call(t)))return o;throw TypeError("Can't convert object to primitive value")}},function(t,e,n){var r=n(2),o=n(29),i=n(21),u=r["__core-js_shared__"]||o("__core-js_shared__",{});(t.exports=function(t,e){return u[t]||(u[t]=void 0!==e?e:{})})("versions",[]).push({version:"3.1.3",mode:i?"pure":"global",copyright:"© 2019 Denis Pushkarev (zloirock.ru)"})},function(t,e,n){var r=n(53),o=n(32).concat("length","prototype");e.f=Object.getOwnPropertyNames||function(t){return r(t,o)}},function(t,e){t.exports=!1},function(t,e,n){var r,o,i,u=n(79),c=n(2),s=n(5),a=n(8),f=n(6),l=n(23),p=n(24),v=c.WeakMap;if(u){var h=new v,d=h.get,g=h.has,y=h.set;r=function(t,e){return y.call(h,t,e),e},o=function(t){return d.call(h,t)||{}},i=function(t){return g.call(h,t)}}else{var m=l("state");p[m]=!0,r=function(t,e){return a(t,m,e),e},o=function(t){return f(t,m)?t[m]:{}},i=function(t){return f(t,m)}}t.exports={set:r,get:o,has:i,enforce:function(t){return i(t)?o(t):r(t,{})},getterFor:function(t){return function(e){var n;if(!s(e)||(n=o(e)).type!==t)throw TypeError("Incompatible receiver, "+t+" required");return n}}}},function(t,e,n){var r=n(19),o=n(30),i=r("keys");t.exports=function(t){return i[t]||(i[t]=o(t))}},function(t,e){t.exports={}},function(t,e){var n=Math.ceil,r=Math.floor;t.exports=function(t){return isNaN(t=+t)?0:(t>0?r:n)(t)}},function(t,e,n){var r=n(15);t.exports=Array.isArray||function(t){return"Array"==r(t)}},function(t,e,n){var r=n(7),o=n(81),i=n(32),u=n(24),c=n(82),s=n(48),a=n(23)("IE_PROTO"),f=function(){},l=function(){var t,e=s("iframe"),n=i.length;for(e.style.display="none",c.appendChild(e),e.src=String("javascript:"),(t=e.contentWindow.document).open(),t.write("<script>document.F=Object<\/script>"),t.close(),l=t.F;n--;)delete l.prototype[i[n]];return l()};t.exports=Object.create||function(t,e){var n;return null!==t?(f.prototype=r(t),n=new f,f.prototype=null,n[a]=t):n=l(),void 0===e?n:o(n,e)},u[a]=!0},function(t,e,n){var r=n(0),o=n(15),i="".split;t.exports=r(function(){return!Object("z").propertyIsEnumerable(0)})?function(t){return"String"==o(t)?i.call(t,""):Object(t)}:Object},function(t,e,n){var r=n(2),o=n(8);t.exports=function(t,e){try{o(r,t,e)}catch(n){r[t]=e}return e}},function(t,e){var n=0,r=Math.random();t.exports=function(t){return"Symbol("+String(void 0===t?"":t)+")_"+(++n+r).toString(36)}},function(t,e,n){var r=n(52),o=n(2),i=function(t){return"function"==typeof t?t:void 0};t.exports=function(t,e){return arguments.length<2?i(r[t])||i(o[t]):r[t]&&r[t][e]||o[t]&&o[t][e]}},function(t,e){t.exports=["constructor","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","toLocaleString","toString","valueOf"]},function(t,e,n){var r=n(0),o=/#|\.prototype\./,i=function(t,e){var n=c[u(t)];return n==a||n!=s&&("function"==typeof e?r(e):!!e)},u=i.normalize=function(t){return String(t).replace(o,".").toLowerCase()},c=i.data={},s=i.NATIVE="N",a=i.POLYFILL="P";t.exports=i},function(t,e,n){var r=n(53),o=n(32);t.exports=Object.keys||function(t){return r(t,o)}},function(t,e,n){var r=n(9).f,o=n(6),i=n(1)("toStringTag");t.exports=function(t,e,n){t&&!o(t=n?t:t.prototype,i)&&r(t,i,{configurable:!0,value:e})}},function(t,e,n){var r=n(84),o=n(28),i=n(16),u=n(13),c=n(60),s=[].push,a=function(t){var e=1==t,n=2==t,a=3==t,f=4==t,l=6==t,p=5==t||l;return function(v,h,d,g){for(var y,m,b=i(v),x=o(b),S=r(h,d,3),w=u(x.length),O=0,j=g||c,T=e?j(v,w):n?j(v,0):void 0;w>O;O++)if((p||O in x)&&(m=S(y=x[O],O,b),t))if(e)T[O]=m;else if(m)switch(t){case 3:return!0;case 5:return y;case 6:return O;case 2:s.call(T,y)}else if(f)return!1;return l?-1:a||f?f:T}};t.exports={forEach:a(0),map:a(1),filter:a(2),some:a(3),every:a(4),find:a(5),findIndex:a(6)}},function(t,e,n){"use strict";var r=n(18),o=n(9),i=n(17);t.exports=function(t,e,n){var u=r(e);u in t?o.f(t,u,i(0,n)):t[u]=n}},function(t,e,n){var r=n(0),o=n(1)("species");t.exports=function(t){return!r(function(){var e=[];return(e.constructor={})[o]=function(){return{foo:1}},1!==e[t](Boolean).foo})}},function(t,e,n){"use strict";var r=n(8),o=n(12),i=n(0),u=n(1),c=n(40),s=u("species"),a=!i(function(){var t=/./;return t.exec=function(){var t=[];return t.groups={a:"7"},t},"7"!=="".replace(t,"$<a>")}),f=!i(function(){var t=/(?:)/,e=t.exec;t.exec=function(){return e.apply(this,arguments)};var n="ab".split(t);return 2!==n.length||"a"!==n[0]||"b"!==n[1]});t.exports=function(t,e,n,l){var p=u(t),v=!i(function(){var e={};return e[p]=function(){return 7},7!=""[t](e)}),h=v&&!i(function(){var e=!1,n=/a/;return n.exec=function(){return e=!0,null},"split"===t&&(n.constructor={},n.constructor[s]=function(){return n}),n[p](""),!e});if(!v||!h||"replace"===t&&!a||"split"===t&&!f){var d=/./[p],g=n(p,""[t],function(t,e,n,r,o){return e.exec===c?v&&!o?{done:!0,value:d.call(e,n,r)}:{done:!0,value:t.call(n,e,r)}:{done:!1}}),y=g[0],m=g[1];o(String.prototype,t,y),o(RegExp.prototype,p,2==e?function(t,e){return m.call(t,this,e)}:function(t){return m.call(t,this)}),l&&r(RegExp.prototype[p],"sham",!0)}}},function(t,e,n){"use strict";var r,o,i=n(41),u=RegExp.prototype.exec,c=String.prototype.replace,s=u,a=(r=/a/,o=/b*/g,u.call(r,"a"),u.call(o,"a"),0!==r.lastIndex||0!==o.lastIndex),f=void 0!==/()??/.exec("")[1];(a||f)&&(s=function(t){var e,n,r,o,s=this;return f&&(n=new RegExp("^"+s.source+"$(?!\\s)",i.call(s))),a&&(e=s.lastIndex),r=u.call(s,t),a&&r&&(s.lastIndex=s.global?r.index+r[0].length:e),f&&r&&r.length>1&&c.call(r[0],n,function(){for(o=1;o<arguments.length-2;o++)void 0===arguments[o]&&(r[o]=void 0)}),r}),t.exports=s},function(t,e,n){"use strict";var r=n(7);t.exports=function(){var t=r(this),e="";return t.global&&(e+="g"),t.ignoreCase&&(e+="i"),t.multiline&&(e+="m"),t.dotAll&&(e+="s"),t.unicode&&(e+="u"),t.sticky&&(e+="y"),e}},function(t,e,n){"use strict";var r=n(64).charAt;t.exports=function(t,e,n){return e+(n?r(t,e).length:1)}},function(t,e,n){var r=n(15),o=n(40);t.exports=function(t,e){var n=t.exec;if("function"==typeof n){var i=n.call(t,e);if("object"!=typeof i)throw TypeError("RegExp exec method returned something other than an Object or null");return i}if("RegExp"!==r(t))throw TypeError("RegExp#exec called on incompatible receiver");return o.call(t,e)}},function(t,e){t.exports={}},function(t,e,n){"use strict";var r=n(3),o=n(2),i=n(21),u=n(4),c=n(56),s=n(0),a=n(6),f=n(26),l=n(5),p=n(7),v=n(16),h=n(10),d=n(18),g=n(17),y=n(27),m=n(34),b=n(20),x=n(83),S=n(55),w=n(14),O=n(9),j=n(46),T=n(8),E=n(12),I=n(19),M=n(23),A=n(24),P=n(30),N=n(1),k=n(57),L=n(58),_=n(35),R=n(22),D=n(36).forEach,C=M("hidden"),F=N("toPrimitive"),$=R.set,G=R.getterFor("Symbol"),H=Object.prototype,V=o.Symbol,q=o.JSON,z=q&&q.stringify,U=w.f,Y=O.f,B=x.f,W=j.f,J=I("symbols"),X=I("op-symbols"),K=I("string-to-symbol-registry"),Q=I("symbol-to-string-registry"),Z=I("wks"),tt=o.QObject,et=!tt||!tt.prototype||!tt.prototype.findChild,nt=u&&s(function(){return 7!=y(Y({},"a",{get:function(){return Y(this,"a",{value:7}).a}})).a})?function(t,e,n){var r=U(H,e);r&&delete H[e],Y(t,e,n),r&&t!==H&&Y(H,e,r)}:Y,rt=function(t,e){var n=J[t]=y(V.prototype);return $(n,{type:"Symbol",tag:t,description:e}),u||(n.description=e),n},ot=c&&"symbol"==typeof V.iterator?function(t){return"symbol"==typeof t}:function(t){return Object(t)instanceof V},it=function(t,e,n){t===H&&it(X,e,n),p(t);var r=d(e,!0);return p(n),a(J,r)?(n.enumerable?(a(t,C)&&t[C][r]&&(t[C][r]=!1),n=y(n,{enumerable:g(0,!1)})):(a(t,C)||Y(t,C,g(1,{})),t[C][r]=!0),nt(t,r,n)):Y(t,r,n)},ut=function(t,e){p(t);var n=h(e),r=m(n).concat(ft(n));return D(r,function(e){u&&!ct.call(n,e)||it(t,e,n[e])}),t},ct=function(t){var e=d(t,!0),n=W.call(this,e);return!(this===H&&a(J,e)&&!a(X,e))&&(!(n||!a(this,e)||!a(J,e)||a(this,C)&&this[C][e])||n)},st=function(t,e){var n=h(t),r=d(e,!0);if(n!==H||!a(J,r)||a(X,r)){var o=U(n,r);return!o||!a(J,r)||a(n,C)&&n[C][r]||(o.enumerable=!0),o}},at=function(t){var e=B(h(t)),n=[];return D(e,function(t){a(J,t)||a(A,t)||n.push(t)}),n},ft=function(t){var e=t===H,n=B(e?X:h(t)),r=[];return D(n,function(t){!a(J,t)||e&&!a(H,t)||r.push(J[t])}),r};c||(E((V=function(){if(this instanceof V)throw TypeError("Symbol is not a constructor");var t=arguments.length&&void 0!==arguments[0]?String(arguments[0]):void 0,e=P(t),n=function(t){this===H&&n.call(X,t),a(this,C)&&a(this[C],e)&&(this[C][e]=!1),nt(this,e,g(1,t))};return u&&et&&nt(H,e,{configurable:!0,set:n}),rt(e,t)}).prototype,"toString",function(){return G(this).tag}),j.f=ct,O.f=it,w.f=st,b.f=x.f=at,S.f=ft,u&&(Y(V.prototype,"description",{configurable:!0,get:function(){return G(this).description}}),i||E(H,"propertyIsEnumerable",ct,{unsafe:!0})),k.f=function(t){return rt(N(t),t)}),r({global:!0,wrap:!0,forced:!c,sham:!c},{Symbol:V}),D(m(Z),function(t){L(t)}),r({target:"Symbol",stat:!0,forced:!c},{for:function(t){var e=String(t);if(a(K,e))return K[e];var n=V(e);return K[e]=n,Q[n]=e,n},keyFor:function(t){if(!ot(t))throw TypeError(t+" is not a symbol");if(a(Q,t))return Q[t]},useSetter:function(){et=!0},useSimple:function(){et=!1}}),r({target:"Object",stat:!0,forced:!c,sham:!u},{create:function(t,e){return void 0===e?y(t):ut(y(t),e)},defineProperty:it,defineProperties:ut,getOwnPropertyDescriptor:st}),r({target:"Object",stat:!0,forced:!c},{getOwnPropertyNames:at,getOwnPropertySymbols:ft}),r({target:"Object",stat:!0,forced:s(function(){S.f(1)})},{getOwnPropertySymbols:function(t){return S.f(v(t))}}),q&&r({target:"JSON",stat:!0,forced:!c||s(function(){var t=V();return"[null]"!=z([t])||"{}"!=z({a:t})||"{}"!=z(Object(t))})},{stringify:function(t){for(var e,n,r=[t],o=1;arguments.length>o;)r.push(arguments[o++]);if(n=e=r[1],(l(e)||void 0!==t)&&!ot(t))return f(e)||(e=function(t,e){if("function"==typeof n&&(e=n.call(this,t,e)),!ot(e))return e}),r[1]=e,z.apply(q,r)}}),V.prototype[F]||T(V.prototype,F,V.prototype.valueOf),_(V,"Symbol"),A[C]=!0},function(t,e,n){"use strict";var r={}.propertyIsEnumerable,o=Object.getOwnPropertyDescriptor,i=o&&!r.call({1:2},1);e.f=i?function(t){var e=o(this,t);return!!e&&e.enumerable}:r},function(t,e,n){var r=n(4),o=n(0),i=n(48);t.exports=!r&&!o(function(){return 7!=Object.defineProperty(i("div"),"a",{get:function(){return 7}}).a})},function(t,e,n){var r=n(2),o=n(5),i=r.document,u=o(i)&&o(i.createElement);t.exports=function(t){return u?i.createElement(t):{}}},function(t,e,n){var r=n(19);t.exports=r("native-function-to-string",Function.toString)},function(t,e,n){var r=n(6),o=n(51),i=n(14),u=n(9);t.exports=function(t,e){for(var n=o(e),c=u.f,s=i.f,a=0;a<n.length;a++){var f=n[a];r(t,f)||c(t,f,s(e,f))}}},function(t,e,n){var r=n(31),o=n(20),i=n(55),u=n(7);t.exports=r("Reflect","ownKeys")||function(t){var e=o.f(u(t)),n=i.f;return n?e.concat(n(t)):e}},function(t,e,n){t.exports=n(2)},function(t,e,n){var r=n(6),o=n(10),i=n(80).indexOf,u=n(24);t.exports=function(t,e){var n,c=o(t),s=0,a=[];for(n in c)!r(u,n)&&r(c,n)&&a.push(n);for(;e.length>s;)r(c,n=e[s++])&&(~i(a,n)||a.push(n));return a}},function(t,e,n){var r=n(25),o=Math.max,i=Math.min;t.exports=function(t,e){var n=r(t);return n<0?o(n+e,0):i(n,e)}},function(t,e){e.f=Object.getOwnPropertySymbols},function(t,e,n){var r=n(0);t.exports=!!Object.getOwnPropertySymbols&&!r(function(){return!String(Symbol())})},function(t,e,n){e.f=n(1)},function(t,e,n){var r=n(52),o=n(6),i=n(57),u=n(9).f;t.exports=function(t){var e=r.Symbol||(r.Symbol={});o(e,t)||u(e,t,{value:i.f(t)})}},function(t,e){t.exports=function(t){if("function"!=typeof t)throw TypeError(String(t)+" is not a function");return t}},function(t,e,n){var r=n(5),o=n(26),i=n(1)("species");t.exports=function(t,e){var n;return o(t)&&("function"!=typeof(n=t.constructor)||n!==Array&&!o(n.prototype)?r(n)&&null===(n=n[i])&&(n=void 0):n=void 0),new(void 0===n?Array:n)(0===e?0:e)}},function(t,e,n){"use strict";var r=n(3),o=n(0),i=n(26),u=n(5),c=n(16),s=n(13),a=n(37),f=n(60),l=n(38),p=n(1)("isConcatSpreadable"),v=!o(function(){var t=[];return t[p]=!1,t.concat()[0]!==t}),h=l("concat"),d=function(t){if(!u(t))return!1;var e=t[p];return void 0!==e?!!e:i(t)};r({target:"Array",proto:!0,forced:!v||!h},{concat:function(t){var e,n,r,o,i,u=c(this),l=f(u,0),p=0;for(e=-1,r=arguments.length;e<r;e++)if(i=-1===e?u:arguments[e],d(i)){if(p+(o=s(i.length))>9007199254740991)throw TypeError("Maximum allowed index exceeded");for(n=0;n<o;n++,p++)n in i&&a(l,p,i[n])}else{if(p>=9007199254740991)throw TypeError("Maximum allowed index exceeded");a(l,p++,i)}return l.length=p,l}})},function(t,e,n){"use strict";var r=n(0);t.exports=function(t,e){var n=[][t];return!n||!r(function(){n.call(null,e||function(){throw 1},1)})}},function(t,e,n){"use strict";var r=n(39),o=n(7),i=n(16),u=n(13),c=n(25),s=n(11),a=n(42),f=n(43),l=Math.max,p=Math.min,v=Math.floor,h=/\$([$&'`]|\d\d?|<[^>]*>)/g,d=/\$([$&'`]|\d\d?)/g;r("replace",2,function(t,e,n){return[function(n,r){var o=s(this),i=null==n?void 0:n[t];return void 0!==i?i.call(n,o,r):e.call(String(o),n,r)},function(t,i){var s=n(e,t,this,i);if(s.done)return s.value;var v=o(t),h=String(this),d="function"==typeof i;d||(i=String(i));var g=v.global;if(g){var y=v.unicode;v.lastIndex=0}for(var m=[];;){var b=f(v,h);if(null===b)break;if(m.push(b),!g)break;""===String(b[0])&&(v.lastIndex=a(h,u(v.lastIndex),y))}for(var x,S="",w=0,O=0;O<m.length;O++){b=m[O];for(var j=String(b[0]),T=l(p(c(b.index),h.length),0),E=[],I=1;I<b.length;I++)E.push(void 0===(x=b[I])?x:String(x));var M=b.groups;if(d){var A=[j].concat(E,T,h);void 0!==M&&A.push(M);var P=String(i.apply(void 0,A))}else P=r(j,h,T,E,M,i);T>=w&&(S+=h.slice(w,T)+P,w=T+j.length)}return S+h.slice(w)}];function r(t,n,r,o,u,c){var s=r+t.length,a=o.length,f=d;return void 0!==u&&(u=i(u),f=h),e.call(c,f,function(e,i){var c;switch(i.charAt(0)){case"$":return"$";case"&":return t;case"`":return n.slice(0,r);case"'":return n.slice(s);case"<":c=u[i.slice(1,-1)];break;default:var f=+i;if(0===f)return e;if(f>a){var l=v(f/10);return 0===l?e:l<=a?void 0===o[l-1]?i.charAt(1):o[l-1]+i.charAt(1):e}c=o[f-1]}return void 0===c?"":c})}})},function(t,e,n){var r=n(25),o=n(11),i=function(t){return function(e,n){var i,u,c=String(o(e)),s=r(n),a=c.length;return s<0||s>=a?t?"":void 0:(i=c.charCodeAt(s))<55296||i>56319||s+1===a||(u=c.charCodeAt(s+1))<56320||u>57343?t?c.charAt(s):i:t?c.slice(s,s+2):u-56320+(i-55296<<10)+65536}};t.exports={codeAt:i(!1),charAt:i(!0)}},function(t,e,n){var r=n(5),o=n(15),i=n(1)("match");t.exports=function(t){var e;return r(t)&&(void 0!==(e=t[i])?!!e:"RegExp"==o(t))}},function(t,e){t.exports={CSSRuleList:0,CSSStyleDeclaration:0,CSSValueList:0,ClientRectList:0,DOMRectList:0,DOMStringList:0,DOMTokenList:1,DataTransferItemList:0,FileList:0,HTMLAllCollection:0,HTMLCollection:0,HTMLFormElement:0,HTMLSelectElement:0,MediaList:0,MimeTypeArray:0,NamedNodeMap:0,NodeList:1,PaintRequestList:0,Plugin:0,PluginArray:0,SVGLengthList:0,SVGNumberList:0,SVGPathSegList:0,SVGPointList:0,SVGStringList:0,SVGTransformList:0,SourceBufferList:0,StyleSheetList:0,TextTrackCueList:0,TextTrackList:0,TouchList:0}},function(t,e,n){"use strict";var r=n(4),o=n(2),i=n(33),u=n(12),c=n(6),s=n(15),a=n(68),f=n(18),l=n(0),p=n(27),v=n(20).f,h=n(14).f,d=n(9).f,g=n(100).trim,y=o.Number,m=y.prototype,b="Number"==s(p(m)),x=function(t){var e,n,r,o,i,u,c,s,a=f(t,!1);if("string"==typeof a&&a.length>2)if(43===(e=(a=g(a)).charCodeAt(0))||45===e){if(88===(n=a.charCodeAt(2))||120===n)return NaN}else if(48===e){switch(a.charCodeAt(1)){case 66:case 98:r=2,o=49;break;case 79:case 111:r=8,o=55;break;default:return+a}for(u=(i=a.slice(2)).length,c=0;c<u;c++)if((s=i.charCodeAt(c))<48||s>o)return NaN;return parseInt(i,r)}return+a};if(i("Number",!y(" 0o1")||!y("0b1")||y("+0x1"))){for(var S,w=function(t){var e=arguments.length<1?0:t,n=this;return n instanceof w&&(b?l(function(){m.valueOf.call(n)}):"Number"!=s(n))?a(new y(x(e)),n,w):x(e)},O=r?v(y):"MAX_VALUE,MIN_VALUE,NaN,NEGATIVE_INFINITY,POSITIVE_INFINITY,EPSILON,isFinite,isInteger,isNaN,isSafeInteger,MAX_SAFE_INTEGER,MIN_SAFE_INTEGER,parseFloat,parseInt,isInteger".split(","),j=0;O.length>j;j++)c(y,S=O[j])&&!c(w,S)&&d(w,S,h(y,S));w.prototype=m,m.constructor=w,u(o,"Number",w)}},function(t,e,n){var r=n(5),o=n(69);t.exports=function(t,e,n){var i,u;return o&&"function"==typeof(i=e.constructor)&&i!==n&&r(u=i.prototype)&&u!==n.prototype&&o(t,u),t}},function(t,e,n){var r=n(7),o=n(99);t.exports=Object.setPrototypeOf||("__proto__"in{}?function(){var t,e=!1,n={};try{(t=Object.getOwnPropertyDescriptor(Object.prototype,"__proto__").set).call(n,[]),e=n instanceof Array}catch(t){}return function(n,i){return r(n),o(i),e?t.call(n,i):n.__proto__=i,n}}():void 0)},function(t,e,n){n(3)({target:"Number",stat:!0},{isNaN:function(t){return t!=t}})},function(t,e,n){var r=n(12),o=n(102),i=Object.prototype;o!==i.toString&&r(i,"toString",o,{unsafe:!0})},function(t,e,n){"use strict";var r=n(12),o=n(7),i=n(0),u=n(41),c=RegExp.prototype,s=c.toString,a=i(function(){return"/a/b"!=s.call({source:"a",flags:"b"})}),f="toString"!=s.name;(a||f)&&r(RegExp.prototype,"toString",function(){var t=o(this),e=String(t.source),n=t.flags;return"/"+e+"/"+String(void 0===n&&t instanceof RegExp&&!("flags"in c)?u.call(t):n)},{unsafe:!0})},function(t,e,n){"use strict";var r=n(10),o=n(108),i=n(44),u=n(22),c=n(74),s=u.set,a=u.getterFor("Array Iterator");t.exports=c(Array,"Array",function(t,e){s(this,{type:"Array Iterator",target:r(t),index:0,kind:e})},function(){var t=a(this),e=t.target,n=t.kind,r=t.index++;return!e||r>=e.length?(t.target=void 0,{value:void 0,done:!0}):"keys"==n?{value:r,done:!1}:"values"==n?{value:e[r],done:!1}:{value:[r,e[r]],done:!1}},"values"),i.Arguments=i.Array,o("keys"),o("values"),o("entries")},function(t,e,n){"use strict";var r=n(3),o=n(109),i=n(76),u=n(69),c=n(35),s=n(8),a=n(12),f=n(1),l=n(21),p=n(44),v=n(75),h=v.IteratorPrototype,d=v.BUGGY_SAFARI_ITERATORS,g=f("iterator"),y=function(){return this};t.exports=function(t,e,n,f,v,m,b){o(n,e,f);var x,S,w,O=function(t){if(t===v&&M)return M;if(!d&&t in E)return E[t];switch(t){case"keys":case"values":case"entries":return function(){return new n(this,t)}}return function(){return new n(this)}},j=e+" Iterator",T=!1,E=t.prototype,I=E[g]||E["@@iterator"]||v&&E[v],M=!d&&I||O(v),A="Array"==e&&E.entries||I;if(A&&(x=i(A.call(new t)),h!==Object.prototype&&x.next&&(l||i(x)===h||(u?u(x,h):"function"!=typeof x[g]&&s(x,g,y)),c(x,j,!0,!0),l&&(p[j]=y))),"values"==v&&I&&"values"!==I.name&&(T=!0,M=function(){return I.call(this)}),l&&!b||E[g]===M||s(E,g,M),p[e]=M,v)if(S={values:O("values"),keys:m?M:O("keys"),entries:O("entries")},b)for(w in S)!d&&!T&&w in E||a(E,w,S[w]);else r({target:e,proto:!0,forced:d||T},S);return S}},function(t,e,n){"use strict";var r,o,i,u=n(76),c=n(8),s=n(6),a=n(1),f=n(21),l=a("iterator"),p=!1;[].keys&&("next"in(i=[].keys())?(o=u(u(i)))!==Object.prototype&&(r=o):p=!0),null==r&&(r={}),f||s(r,l)||c(r,l,function(){return this}),t.exports={IteratorPrototype:r,BUGGY_SAFARI_ITERATORS:p}},function(t,e,n){var r=n(6),o=n(16),i=n(23),u=n(110),c=i("IE_PROTO"),s=Object.prototype;t.exports=u?Object.getPrototypeOf:function(t){return t=o(t),r(t,c)?t[c]:"function"==typeof t.constructor&&t instanceof t.constructor?t.constructor.prototype:t instanceof Object?s:null}},function(t,e,n){t.exports=n(113)},function(t,e){var n;n=function(){return this}();try{n=n||new Function("return this")()}catch(t){"object"==typeof window&&(n=window)}t.exports=n},function(t,e,n){var r=n(2),o=n(49),i=r.WeakMap;t.exports="function"==typeof i&&/native code/.test(o.call(i))},function(t,e,n){var r=n(10),o=n(13),i=n(54),u=function(t){return function(e,n,u){var c,s=r(e),a=o(s.length),f=i(u,a);if(t&&n!=n){for(;a>f;)if((c=s[f++])!=c)return!0}else for(;a>f;f++)if((t||f in s)&&s[f]===n)return t||f||0;return!t&&-1}};t.exports={includes:u(!0),indexOf:u(!1)}},function(t,e,n){var r=n(4),o=n(9),i=n(7),u=n(34);t.exports=r?Object.defineProperties:function(t,e){i(t);for(var n,r=u(e),c=r.length,s=0;c>s;)o.f(t,n=r[s++],e[n]);return t}},function(t,e,n){var r=n(31);t.exports=r("document","documentElement")},function(t,e,n){var r=n(10),o=n(20).f,i={}.toString,u="object"==typeof window&&window&&Object.getOwnPropertyNames?Object.getOwnPropertyNames(window):[];t.exports.f=function(t){return u&&"[object Window]"==i.call(t)?function(t){try{return o(t)}catch(t){return u.slice()}}(t):o(r(t))}},function(t,e,n){var r=n(59);t.exports=function(t,e,n){if(r(t),void 0===e)return t;switch(n){case 0:return function(){return t.call(e)};case 1:return function(n){return t.call(e,n)};case 2:return function(n,r){return t.call(e,n,r)};case 3:return function(n,r,o){return t.call(e,n,r,o)}}return function(){return t.apply(e,arguments)}}},function(t,e,n){"use strict";var r=n(3),o=n(36).filter;r({target:"Array",proto:!0,forced:!n(38)("filter")},{filter:function(t){return o(this,t,arguments.length>1?arguments[1]:void 0)}})},function(t,e,n){"use strict";var r=n(3),o=n(28),i=n(10),u=n(62),c=[].join,s=o!=Object,a=u("join",",");r({target:"Array",proto:!0,forced:s||a},{join:function(t){return c.call(i(this),void 0===t?",":t)}})},function(t,e,n){"use strict";var r=n(3),o=n(5),i=n(26),u=n(54),c=n(13),s=n(10),a=n(37),f=n(38),l=n(1)("species"),p=[].slice,v=Math.max;r({target:"Array",proto:!0,forced:!f("slice")},{slice:function(t,e){var n,r,f,h=s(this),d=c(h.length),g=u(t,d),y=u(void 0===e?d:e,d);if(i(h)&&("function"!=typeof(n=h.constructor)||n!==Array&&!i(n.prototype)?o(n)&&null===(n=n[l])&&(n=void 0):n=void 0,n===Array||void 0===n))return p.call(h,g,y);for(r=new(void 0===n?Array:n)(v(y-g,0)),f=0;g<y;g++,f++)g in h&&a(r,f,h[g]);return r.length=f,r}})},function(t,e,n){var r=n(3),o=n(0),i=n(10),u=n(14).f,c=n(4),s=o(function(){u(1)});r({target:"Object",stat:!0,forced:!c||s,sham:!c},{getOwnPropertyDescriptor:function(t,e){return u(i(t),e)}})},function(t,e,n){var r=n(3),o=n(4),i=n(51),u=n(10),c=n(14),s=n(37);r({target:"Object",stat:!0,sham:!o},{getOwnPropertyDescriptors:function(t){for(var e,n,r=u(t),o=c.f,a=i(r),f={},l=0;a.length>l;)void 0!==(n=o(r,e=a[l++]))&&s(f,e,n);return f}})},function(t,e,n){var r=n(3),o=n(16),i=n(34);r({target:"Object",stat:!0,forced:n(0)(function(){i(1)})},{keys:function(t){return i(o(t))}})},function(t,e,n){"use strict";var r=n(39),o=n(65),i=n(7),u=n(11),c=n(92),s=n(42),a=n(13),f=n(43),l=n(40),p=n(0),v=[].push,h=Math.min,d=!p(function(){return!RegExp(4294967295,"y")});r("split",2,function(t,e,n){var r;return r="c"=="abbc".split(/(b)*/)[1]||4!="test".split(/(?:)/,-1).length||2!="ab".split(/(?:ab)*/).length||4!=".".split(/(.?)(.?)/).length||".".split(/()()/).length>1||"".split(/.?/).length?function(t,n){var r=String(u(this)),i=void 0===n?4294967295:n>>>0;if(0===i)return[];if(void 0===t)return[r];if(!o(t))return e.call(r,t,i);for(var c,s,a,f=[],p=(t.ignoreCase?"i":"")+(t.multiline?"m":"")+(t.unicode?"u":"")+(t.sticky?"y":""),h=0,d=new RegExp(t.source,p+"g");(c=l.call(d,r))&&!((s=d.lastIndex)>h&&(f.push(r.slice(h,c.index)),c.length>1&&c.index<r.length&&v.apply(f,c.slice(1)),a=c[0].length,h=s,f.length>=i));)d.lastIndex===c.index&&d.lastIndex++;return h===r.length?!a&&d.test("")||f.push(""):f.push(r.slice(h)),f.length>i?f.slice(0,i):f}:"0".split(void 0,0).length?function(t,n){return void 0===t&&0===n?[]:e.call(this,t,n)}:e,[function(e,n){var o=u(this),i=null==e?void 0:e[t];return void 0!==i?i.call(e,o,n):r.call(String(o),e,n)},function(t,o){var u=n(r,t,this,o,r!==e);if(u.done)return u.value;var l=i(t),p=String(this),v=c(l,RegExp),g=l.unicode,y=(l.ignoreCase?"i":"")+(l.multiline?"m":"")+(l.unicode?"u":"")+(d?"y":"g"),m=new v(d?l:"^(?:"+l.source+")",y),b=void 0===o?4294967295:o>>>0;if(0===b)return[];if(0===p.length)return null===f(m,p)?[p]:[];for(var x=0,S=0,w=[];S<p.length;){m.lastIndex=d?S:0;var O,j=f(m,d?p:p.slice(S));if(null===j||(O=h(a(m.lastIndex+(d?0:S)),p.length))===x)S=s(p,S,g);else{if(w.push(p.slice(x,S)),w.length===b)return w;for(var T=1;T<=j.length-1;T++)if(w.push(j[T]),w.length===b)return w;S=x=O}}return w.push(p.slice(x)),w}]},!d)},function(t,e,n){var r=n(7),o=n(59),i=n(1)("species");t.exports=function(t,e){var n,u=r(t).constructor;return void 0===u||null==(n=r(u)[i])?e:o(n)}},function(t,e,n){"use strict";var r=n(3),o=n(94);r({target:"String",proto:!0,forced:n(95)("fixed")},{fixed:function(){return o(this,"tt","","")}})},function(t,e,n){var r=n(11),o=/"/g;t.exports=function(t,e,n,i){var u=String(r(t)),c="<"+e;return""!==n&&(c+=" "+n+'="'+String(i).replace(o,"&quot;")+'"'),c+">"+u+"</"+e+">"}},function(t,e,n){var r=n(0);t.exports=function(t){return r(function(){var e=""[t]('"');return e!==e.toLowerCase()||e.split('"').length>3})}},function(t,e,n){var r=n(2),o=n(66),i=n(97),u=n(8);for(var c in o){var s=r[c],a=s&&s.prototype;if(a&&a.forEach!==i)try{u(a,"forEach",i)}catch(t){a.forEach=i}}},function(t,e,n){"use strict";var r=n(36).forEach,o=n(62);t.exports=o("forEach")?function(t){return r(this,t,arguments.length>1?arguments[1]:void 0)}:[].forEach},function(t,e,n){"use strict";var r=n(39),o=n(7),i=n(13),u=n(11),c=n(42),s=n(43);r("match",1,function(t,e,n){return[function(e){var n=u(this),r=null==e?void 0:e[t];return void 0!==r?r.call(e,n):new RegExp(e)[t](String(n))},function(t){var r=n(e,t,this);if(r.done)return r.value;var u=o(t),a=String(this);if(!u.global)return s(u,a);var f=u.unicode;u.lastIndex=0;for(var l,p=[],v=0;null!==(l=s(u,a));){var h=String(l[0]);p[v]=h,""===h&&(u.lastIndex=c(a,i(u.lastIndex),f)),v++}return 0===v?null:p}]})},function(t,e,n){var r=n(5);t.exports=function(t){if(!r(t)&&null!==t)throw TypeError("Can't set "+String(t)+" as a prototype");return t}},function(t,e,n){var r=n(11),o="["+n(101)+"]",i=RegExp("^"+o+o+"*"),u=RegExp(o+o+"*$"),c=function(t){return function(e){var n=String(r(e));return 1&t&&(n=n.replace(i,"")),2&t&&(n=n.replace(u,"")),n}};t.exports={start:c(1),end:c(2),trim:c(3)}},function(t,e){t.exports="\t\n\v\f\r                　\u2028\u2029\ufeff"},function(t,e,n){"use strict";var r=n(103),o={};o[n(1)("toStringTag")]="z",t.exports="[object z]"!==String(o)?function(){return"[object "+r(this)+"]"}:o.toString},function(t,e,n){var r=n(15),o=n(1)("toStringTag"),i="Arguments"==r(function(){return arguments}());t.exports=function(t){var e,n,u;return void 0===t?"Undefined":null===t?"Null":"string"==typeof(n=function(t,e){try{return t[e]}catch(t){}}(e=Object(t),o))?n:i?r(e):"Object"==(u=r(e))&&"function"==typeof e.callee?"Arguments":u}},function(t,e,n){var r=n(4),o=n(2),i=n(33),u=n(68),c=n(9).f,s=n(20).f,a=n(65),f=n(41),l=n(12),p=n(0),v=n(105),h=n(1)("match"),d=o.RegExp,g=d.prototype,y=/a/g,m=/a/g,b=new d(y)!==y;if(r&&i("RegExp",!b||p(function(){return m[h]=!1,d(y)!=y||d(m)==m||"/a/i"!=d(y,"i")}))){for(var x=function(t,e){var n=this instanceof x,r=a(t),o=void 0===e;return!n&&r&&t.constructor===x&&o?t:u(b?new d(r&&!o?t.source:t,e):d((r=t instanceof x)?t.source:t,r&&o?f.call(t):e),n?this:g,x)},S=function(t){t in x||c(x,t,{configurable:!0,get:function(){return d[t]},set:function(e){d[t]=e}})},w=s(d),O=0;w.length>O;)S(w[O++]);g.constructor=x,x.prototype=g,l(o,"RegExp",x)}v("RegExp")},function(t,e,n){"use strict";var r=n(31),o=n(9),i=n(1),u=n(4),c=i("species");t.exports=function(t){var e=r(t),n=o.f;u&&e&&!e[c]&&n(e,c,{configurable:!0,get:function(){return this}})}},function(t,e,n){"use strict";var r=n(3),o=n(4),i=n(2),u=n(6),c=n(5),s=n(9).f,a=n(50),f=i.Symbol;if(o&&"function"==typeof f&&(!("description"in f.prototype)||void 0!==f().description)){var l={},p=function(){var t=arguments.length<1||void 0===arguments[0]?void 0:String(arguments[0]),e=this instanceof p?new f(t):void 0===t?f():f(t);return""===t&&(l[e]=!0),e};a(p,f);var v=p.prototype=f.prototype;v.constructor=p;var h=v.toString,d="Symbol(test)"==String(f("test")),g=/^Symbol\((.*)\)[^)]+$/;s(v,"description",{configurable:!0,get:function(){var t=c(this)?this.valueOf():this,e=h.call(t);if(u(l,t))return"";var n=d?e.slice(7,-1):e.replace(g,"$1");return""===n?void 0:n}}),r({global:!0,forced:!0},{Symbol:p})}},function(t,e,n){n(58)("iterator")},function(t,e,n){var r=n(1),o=n(27),i=n(8),u=r("unscopables"),c=Array.prototype;null==c[u]&&i(c,u,o(null)),t.exports=function(t){c[u][t]=!0}},function(t,e,n){"use strict";var r=n(75).IteratorPrototype,o=n(27),i=n(17),u=n(35),c=n(44),s=function(){return this};t.exports=function(t,e,n){var a=e+" Iterator";return t.prototype=o(r,{next:i(1,n)}),u(t,a,!1,!0),c[a]=s,t}},function(t,e,n){var r=n(0);t.exports=!r(function(){function t(){}return t.prototype.constructor=null,Object.getPrototypeOf(new t)!==t.prototype})},function(t,e,n){"use strict";var r=n(64).charAt,o=n(22),i=n(74),u=o.set,c=o.getterFor("String Iterator");i(String,"String",function(t){u(this,{type:"String Iterator",string:String(t),index:0})},function(){var t,e=c(this),n=e.string,o=e.index;return o>=n.length?{value:void 0,done:!0}:(t=r(n,o),e.index+=t.length,{value:t,done:!1})})},function(t,e,n){var r=n(2),o=n(66),i=n(73),u=n(8),c=n(1),s=c("iterator"),a=c("toStringTag"),f=i.values;for(var l in o){var p=r[l],v=p&&p.prototype;if(v){if(v[s]!==f)try{u(v,s,f)}catch(t){v[s]=f}if(v[a]||u(v,a,l),o[l])for(var h in i)if(v[h]!==i[h])try{u(v,h,i[h])}catch(t){v[h]=i[h]}}}},function(t,e,n){"use strict";n.r(e);n(45),n(61),n(85),n(86),n(87),n(88),n(89),n(90),n(63),n(91),n(93),n(96);var r={start:{time:0},end:{time:0},totalMilliseconds:0,interval:100,pre:!0,format:"DD : HH: MM : SS : SSS",auto:!0,fixed:!1,lang:"en",themeClass:!1,state:!0,stateText:null},o={en:{DD:"days",HH:"hours",MM:"minutes",SS:"seconds",sss:"milliseconds"},zh:{DD:"天",HH:"小时",MM:"分钟",SS:"秒",sss:"毫秒"}},i={en:{before:"Activity not started",progress:"Activity in progress",after:"Activity is over"},zh:{before:"活动未开始",progress:"活动进行中",after:"活动已结束"}},u="1.2.2";n(98);n(67),n(70),n(71),n(72);var c=Object.prototype.toString;function s(t){return"[object Date]"===c.call(t)&&!Number.isNaN(t.getTime())}function a(t){if(s(t))return t.getTime();if("string"==typeof t&&t.indexOf("-")){var e=t.match(/^(\d{4})-?(\d{1,2})-?(\d{0,2})[\s]?(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.|\s]?(\d{1,3})?$/),n=new Date(NaN);if(function(t){return null!=t}(r=e)&&"number"==typeof r.length&&"function"!=typeof r&&(n=new Date(e[1],e[2]-1||0,e[3]||1,e[4]||0,e[5]||0,e[6]||0,e[7]||0)),s(n))return n.getTime()}var r,o=parseInt(t,10);return s(new Date(o))?o:0}var f="undefined"!=typeof window;n(104),n(106),n(107),n(73),n(111),n(112);function l(t){return(l="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t})(t)}function p(t){return null!==(e=t)&&("object"===l(e)||"function"==typeof e)&&1===t.nodeType;var e}var v=function(t){return new RegExp("(^|\\s)".concat(t,"($|\\s)"))},h=function(t,e){return!!p(t)&&(t.classList?t.classList.contains(e):v(e).test(t.className))},d=function(t,e){p(t)&&!h(t,e)&&(t.classList?t.classList.add(e):t.setAtrribute("class","".concat(t.className," ").concat(e)))},g=function(t,e){var n=v(e);p(t)&&h(t,e)&&(t.classList?t.classList.remove(e):t.className.replace(n,""))};function y(t,e){var n=Object.keys(t);return Object.getOwnPropertySymbols&&n.push.apply(n,Object.getOwnPropertySymbols(t)),e&&(n=n.filter(function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable})),n}function m(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}function b(t,e){for(var n=0;n<e.length;n++){var r=e[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(t,r.key,r)}}var x=function(){function t(e,n){!function(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}(this,t),this.offset={day:0,hour:0,minute:0,second:0},this.$el=document.querySelector(e),this.options=function(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?y(n,!0).forEach(function(e){m(t,e,n[e])}):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):y(n).forEach(function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))})}return t}({},r,{},n),this.state="other",this.edgeTime=Date.now(),this.init(),this.version=u}var e,n,c;return e=t,(n=[{key:"init",value:function(){this.options.stateText||(this.options.stateText=i[this.options.lang]),this.parseInputTime(),this.totalMilliseconds=Math.abs(Date.now()-this.edgeTime),this.options.pre||(this.edgeTime-=this.options.interval),this.options.auto?this.start():(this.setOffset(),this.render(),this.$el&&g(this.$el,"disabled"))}},{key:"start",value:function(){this.$el&&h(this.$el,"disabled")&&g(this.$el,"disabled"),this.setOffset(),this.render(),this.reComputeMilliseconds(),this.continue()}},{key:"continue",value:function(){var t=this,e=Math.min(t.totalMilliseconds,t.options.interval);if(e>0)if(window.requestAnimationFrame){var n=null;t.requestId=window.requestAnimationFrame(function r(o){n||(n=o),o-n<e?t.requestId=window.requestAnimationFrame(r):t.start()})}else t.timeoutId=setTimeout(function(){t.start()},e);else e<=0&&"before"===t.state?setTimeout(function(){t.state="other",t.init()},0):e<=0&&"progress"===t.state?setTimeout(function(){t.state="other",t.init()},0):t.pause()}},{key:"pause",value:function(){window.requestAnimationFrame?window.cancelAnimationFrame(this.requestId):clearTimeout(this.timeoutId),this.$el&&d(this.$el,"disabled")}},{key:"end",value:function(){this.options.fixed&&(this.pause(),this.totalMilliseconds=0,this.edgeTime=0,this.start())}},{key:"reset",value:function(){if(!this.options.fixed)throw new Error("reset status is invalid!");this.parseInputTime(),this.init()}},{key:"getState",value:function(){var t=this.options.start.time,e=this.options.end.time;t>=e&&this.end();var n=Date.now();this.state=n<t?"before":n<=e?"progress":"after"}},{key:"reComputeMilliseconds",value:function(){var t=0;t=this.options.fixed?this.totalMilliseconds-this.options.interval:this.edgeTime-Date.now(),this.totalMilliseconds=t<100?0:t}},{key:"setOffset",value:function(){this.offset.day=Math.floor(this.totalMilliseconds/864e5),this.offset.hour=Math.floor(this.totalMilliseconds/36e5)%24,this.offset.minute=Math.floor(this.totalMilliseconds/6e4)%60,this.offset.second=Math.floor(this.totalMilliseconds/1e3)%60,this.offset.millisecond=Math.floor(this.totalMilliseconds%1e3/this.options.interval)}},{key:"parseInputTime",value:function(){this.options.start.time=a(this.options.start.time),this.options.end.time=a(this.options.end.time);var t,e=0,n=parseInt(this.options.totalMilliseconds,10);t=this.options.totalMilliseconds,!Number.isNaN(t)&&t>0?e=n+Date.now():(this.getState(),"before"===this.state&&(e=this.options.start.time),"progress"===this.state&&(e=this.options.end.time),"after"===this.state&&(e=Date.now())),this.edgeTime=e}},{key:"formatOutputTime",value:function(){return this.options.format.replace(/DD/,this.offset.day<10?"0".concat(this.offset.day):this.offset.day).replace(/HH/,"0".concat(this.offset.hour).slice(-2)).replace(/MM/,"0".concat(this.offset.minute).slice(-2)).replace(/SS/,"0".concat(this.offset.second).slice(-2)).replace(/sss/,"".concat(this.offset.millisecond))}},{key:"getTimeName",value:function(t){for(var e=[],n=t.length,r=0;r<n;r+=1)e.push(o[this.options.lang][t[r]]);return e}},{key:"render",value:function(){if(!this.$el)throw new Error(this.state);var t="",e=[],n=this.options.format.split(" : "),r=this.getTimeName(n),o=this.formatOutputTime().split(" : "),i=this.options.themeClass;if(i&&i.length>0){for(var u=n.length,c=0;c<u;c+=1)e.push('<div class="time-item">\n            <span class="number">'.concat(o[c],'</span>\n            <span class="text">').concat(r[c],"</span>\n          </div>"));t=e.join('<span class="separator">:</span>'),d(this.$el,i)}else t=this.formatOutputTime();this.options.state&&"other"!==this.state&&(t+='<span class="state">'.concat(this.options.stateText[this.state],"</span>")),this.$el.innerHTML=t}}])&&b(e.prototype,n),c&&b(e,c),t}();if(f)throw window.countDown=x,new Error("plugin is running browser.");e.default=x}])});</script>
<script>
//modal mask
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
/* product desc */
function descPrdouct(data) {
	return data.sort(function(item, item2) {
		var compare = item.productHavesalenum - item2.productHavesalenum;
		if (compare > 0) {
			return -1;
		} else if (compare < 0) {
			return 1;
		} else {
			return 0;
		}
	});
}
/* product add/sub */
function productAdd(el, callback) {
	var parentEl = el.parents('.product-qty');
	/* var max = parentEl.find('.product-num').data('count') && parseInt(parentEl.find('.product-num').data('count')) || Infinity; */
	var max = Infinity;
	var curr = parseInt(parentEl.find('.product-num').val());

	curr += 1;
	if (curr > max) {
		curr = max;
		mlModalTip('<p>Existing inventory <b>'+ curr + '</b> pieces !</p>');
	}

	parentEl.find('.product-num').val(curr);
	callback && callback(parentEl, curr);
}
function productSub(el, callback) {
	var parentEl = el.parents('.product-qty');
	var curr = parseInt(parentEl.find('.product-num').val());
	var flag = false;
	curr -= 1;
	if (curr < 1) {
		curr = 1;
		flag = true;
		mlModalTip('<p>At least one product !</p>');
	}

	parentEl.find('.product-num').val(curr);
	callback && callback(parentEl, curr, flag);
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
			(data.code == 100) && callback && callback(data.extend.mbackProductAttributeNameResList);
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
	optionObj = {};
	$('.product-options').html('');
	data.forEach(function(item, idx) {
		createOption(item, selectedRadioArr && selectedRadioArr[idx]);
	});
}
/* get coupon area data */
function getCouponAreaData(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackCouponDescTitle/getMlbackCouponDescTitleListByStatus',
		contentType: 'application/json',
		type: "post",
		async: false,
		success: function (data) {
			(data.code == 100) && callback && callback(data.extend);
		}
	});
}
/* render coupon area */
function renderCouponAreaData(data) {
	function generateCouponAreaDetailsListData(data) {
		var html = '';
		data.forEach(function(item, idx) {
			html += '<li>'+ item.coupondescdetailStrengthpre +'&nbsp;<span class="text-color">&nbsp;'+ item.coupondescdetailStrength +'&nbsp;</span>&nbsp;'+ item.coupondescdetailCodepre +'&nbsp;<b>&nbsp;'+ item.coupondescdetailCode +'</b></li>';
		});
		return html;
	}
	
	function splitData(data) {
		var resData = {
				dis: [],
				full: []
			};
		data.forEach(function(item) {
			if (/%/.test(item.coupondescdetailStrength)) {
				resData.dis.push(item);
			} else {
				resData.full.push(item);
			}
		});
		return resData;
	}
	var $el = $('.product-coupons');
	var $discountEl = $el.find('.discount');
	var $fullEl = $el.find('.full');
	var newData = splitData(data.mlbackCouponDescDetailList);
	var htmlStr = '<div class="left lazyload" data-src="'+  data.mlbackCouponDescTitleList[0].coupondesctieleImgurl +'"></div>' +
				'<div class="right">' +
			'<div class="title">'+ data.mlbackCouponDescTitleList[0].coupondesctieleTieledetail +'</div>' +
			'<div class="body">' +
				'<ul class="discount">' + generateCouponAreaDetailsListData(newData.dis) + '</ul>' +
				'<div class="divider" style="height: 1px;margin: .5rem 0;background-color: #eb8378;"></div>' +
				'<ul class="full">' + generateCouponAreaDetailsListData(newData.full) + '</ul>' +
			'</div>' +
		'</div>';
	
	$el.html(htmlStr);
	
	if (data.mlbackCouponDescTitleList[0].coupondesctieleStatus) {
		$el.removeClass('hide');
	}
	
	new LazyLoad($el.find('.lazyload'), {
		root: null,
		rootMargin: "10px",
		threshold: 0
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
			(data.code == 100) && callback && callback(data.extend.mlbackProductSkuResList);
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
        mapItems[item.productskuName] = item;
        acc.push(item.productskuName);
        return acc;
    }, []);
}
function trimSpliter(str) {
    var reLeft = new RegExp('^,+', 'g'),
    	reRight = new RegExp(',+$', 'g'),
    	reSpliter = new RegExp(',+', 'g');

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

    return selectedItems;
}
function powerset(arr) {
    var ps = [[]];
    for (var i = 0; i < arr.length; i += 1) {
        for (var j = 0, len = ps.length; j < len; j += 1) {
            ps.push(ps[j].concat(arr[i]))
        }
    }
    return ps;
}
function updateProductStatus(selected) {
	var keys = Object.keys(optionObj);
    for (var i = 0, len = keys.length; i < len; i+=1) {
        var key = keys[i],
        	data = optionObj[key],
        	selectArr = selected.slice();
        for (var j = 0; j < data.length; j+=1) {
            var item = String(data[j]),
            	curr,
            	$item;
			selectArr[i] = item;
			curr = trimSpliter(selectArr.join(','), ',');
			$item = $('.product-option-item[data-type="' + key + '"]').find('.radio[data-text="' + item + '"]');
            if (mapSet[curr] && mapSet[curr].count > 0) {
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
        : (el.siblings().removeClass('active'), el.addClass('active'));
}
function showResult() {
    var selectedItems = getSelectedItem(),
    	selectedKeys = [];

    for (var i = 0; i < selectedItems.length; i += 1) {
        var item = selectedItems[i];
        if (!!item) {
            selectedKeys.push(item);
        }
    }

    updateProductData(selectedKeys);
}

// check add/sub product; add-to-cart/buynow product;
function isCorrectProduct() {
	var optionItems = $('.product-option-item'),
		len = optionItems.length,
		flag = true;
	if (!len) {
		cannotBuyProductModal();
		return false;
	}
	// option check
	for (var i = 0; i < len; i += 1) {
		var $optionItem = $(optionItems[i]);
		if (!$optionItem.find('.radio.active').length) {
			mlModalTip('Please select a product specifications and options: <i style="font-weight: blold; color: red;">'+ $optionItem.data('type') + '</i>');
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
function mergeOpts (opts1, opts2) {
    var res = $.extend(true, {}, opts1, opts2);

    $.each(opts2, function (key, value) {
		if ($.isArray(value)) {
			res[key] = value;
		}
    });

    return res;
}
function createModal(option, closeFn) {
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
		autoClose: false,
		blockEvent: false,
	}, option);
	var htmlStr = '';
	var timer = null
	var modal = $('<div class="modal">' +
	    '<div class="modal-close icon close"></div>' +
	    '<div class="modal-container">' +
	    	(opt.header.isShow ? ('<div class="modal-header">' + (opt.header.html ? opt.header.html : '<p>Megalook Tip !</p>') + '</div>') : '') +
	    	('<div class="modal-body">' + opt.body.html + '</div>') +
	    	(opt.footer.isShow
	    			? ('<div class="modal-footer">' + 
	    					(opt.footer.html ? opt.footer.html : '<button class="btn btn-gray modal-no"> No </button><button class="btn btn-pink modal-ok"> Yes </button>') +
	    				'</div>')
	    			: '') +
	    '</div>' +
	'</div>');
	function openTimer() {
		timer = setTimeout(function() {
    		removeModal(modal);
    	}, 1500);
	}
	function setModalZindex(modal) {
		var modalLen = $('.modal').length;
		if (modalLen) modal.css('z-index', (parseInt($('.modal').css('z-index'), 10) + modalLen + 1));
	}
	$(document.body).append(modal);
	setTimeout(function() {
		modal.addClass('active');
	});
    addFixed();
	// modal z-index
	setModalZindex(modal);
    // auto close
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
    // modal close event
    if (!opt.blockEvent) {    	
	    modal.on('click', function (e) {
	        if (e.target == this) {
	        	removeModal($(this));
	        	closeFn && closeFn();
	        }
	    });
	    modal.find('.modal-close, .modal-no').on('click', function (e) {
	        removeModal(modal);
	        closeFn && closeFn();
	    });
    }
    
	return modal;
}
function removeModal(modal) {
	modal.remove();
	!$('.modal').length && removeFixed();
}
/* modal tip */
function mlModalTip(text) {
	var modal = createModal({
		body: {
			html: '<p>'+ text +'</p>'
		},
		autoClose: true,
	});
}

function sysModalTip() {
	mlModalTip('Network anomaly, temporarily unable to get data, please try again later !');
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
function cannotBuyProductModal() {
	mlModalTip("I'm sorry, the goods temporarily can't buy !");
}
function loginNotTip() {
	var loginModal = createModal({
		header: {
			isShow: false,
		},
		body: {
			html: '<p>Not logged in, 3s later, it will jump to the homepage !</p>'
		},
		blockEvent: true,
	});
	loginModal.find('.modal-close').hide();
	setTimeout(goToIndex, 3000);
}
// pay loading
function payLoading() {
	var zIndex = (parseInt($('.modal').css('z-index'), 10) + $('.modal').length + 1) || 99999999999;
	var $payLoading = $('<div class="pay-loading" style="z-index: '+ zIndex +'"><div class="load-list"><div class="loader-item"></div><div class="loader-item"></div><div class="loader-item"></div></div>');
	$(document.body).append($payLoading);
	addFixed();
}
function hidePayLoading() {
	$('.pay-loading').remove();
	removeFixed();
}
/* jump link function */
function goToIndex() {
	window.location.href = '${APP_PATH}/';
}
function goToCheckout() {
	window.location.href = '${APP_PATH}/MlbackCart/toCheakOut';
}
function goToCartList() {
	window.location.href = '${APP_PATH}/MlbackCart/toCartList';
}
/* function goTopayInstance() {
	window.location.href = '${APP_PATH}/paypalProDetailExpress/mpay';
} */
function goToUserCenter() {
	 window.location.href = "${APP_PATH}/MlfrontUser/toUserCenter";
}
function goToUserCenerOrder() {
	window.location.href = "${APP_PATH}/MlfrontUser/tomyOrderPage";
}
function goToUserCenerCoupon() {
	window.location.href = "${APP_PATH}/MlfrontUser/toCouponPage";
}
function goToUserCenerPersonal() {
	window.location.href = "${APP_PATH}/MlfrontUser/toPersonInfoPage";
}
function goToSearchTrack() {
	window.location.href = "${APP_PATH}/MlfrontOrderList/searchTrackPage";
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
		// create $el
		var pageUl = $('<ul class="pagination" />'),
			firstPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('first')),
			prePageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&laquo;')),
			nextPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&raquo;')),
			lastPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('last')),
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
// get slide-area product
function getProductSlideArea(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackSlides/getMlbackSlidewapListByArea',
		data: JSON.stringify({ "slideArea": 3 }),
		type: 'post',
		dataType: 'json',
		contentType: 'application/json',
		success: function (data) {
			(data.code == 100)  && callback && callback(descPrdouct(data.extend.mlbackProductResList || []));
		}
	});
}
function generateSwiperSlideProduct(data) {
	var htmlStr = '';
	var $productSwiper = $('<div class="swiper-container"><div class="swiper-wrapper"></div><div class="swiper-btn swiper-button-next"></div><div class="swiper-btn swiper-button-prev"></div></div>');

	data.forEach(function(item, idx) {
		var productLink = item.productSeo ? '${APP_PATH}/' + item.productSeo + '.html' : 'javascript:;';
		htmlStr += '<div class="swiper-slide product-item" data-productid="'+ item.productId +'">' +
		    '<span class="product-discount-label'+ (item.productDiscoutimgShow ? ' show' : '') +'" style="background-image: url('+ (item.productDiscoutimgurl || '') +');"></span>' +
			'<div class="product-img">' +
				'<a href="'+ productLink +'" title="'+ item.productName +'" class="lazyload" data-src="'+ item.productMainimgurl +'"></a>' +
			'</div>' +
			'<div class="product-desc">' +
				'<div class="product-name"><a href="'+ productLink +'" title="'+ item.productName +'">'+ item.productName +'</a></div>' +
				/* '<div class="product-data">' +
					'<span class="product-pay-num">'+ (item.productHavesalenum || 0) +' Order(s)</span>' +
					'<span class="product-review-num">'+ (item.productReviewnum || 0) +' Review(s)</span>' +
				'</div>' + */
				'<div class="product-price">' +
					'<span class="product-define-price">$'+ (item.productOriginalprice || 0).toFixed(2) +'</span>' +
					'<span class="product-now-price">$'+ (item.productOriginalprice && item.productActoffoff ? accuracyCal(item.productOriginalprice, item.productActoffoff) : 0.00) +'</span>' +
				'</div>' +
			'</div>' +
		'</div>';
	});

	$productSwiper.find('.swiper-wrapper').html(htmlStr);

	return $productSwiper;
}
function renderIntroduceProductSlide($el, data) {
	var productSlide = generateSwiperSlideProduct(data).addClass('introduce-product');
	$el.append('<div class="introduce-product-title">YOU MIGHT ALSO LIKE<div>');
	$el.append(productSlide)
	var productSwiper = new Swiper('.introduce-product.swiper-container', {
		slidesPerView: 'auto',
		spaceBetween: 5,
		freeMode: true,
		autoplay: {
			delay: 5000,
			stopOnLastSlide: false,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.introduce-product .swiper-button-next',
			prevEl: '.introduce-product .swiper-button-prev',
		},
		pagination: {
			el: '.introduce-product .swiper-pagination',
			clickable: true
		},
		on: {
		    resize: function(){
		    	productSwiper.slidesPerView = (window.innerWidth > 799 ? 4 : 2);
		    	productSwiper.updateSlidesOffset();
		    }, 
		}
	});
}
/* Accuracy of calculation */
function accuracyCal(origin, dis) {
	var priceArr = (origin * dis / 100).toString().split('.');
	var acurPrice = priceArr[1];
	var newFixedPrice = '00';

	if (acurPrice) {
		var strFixedPrice = acurPrice.slice(0, 2);
		var fixedPrice = parseInt((strFixedPrice.length == 1 ? strFixedPrice + '0' : strFixedPrice), 10);
		var ap = parseInt(acurPrice.slice(2, 3), 10);
		fixedPrice = (ap > 4 ? (fixedPrice + 1) : fixedPrice);
		newFixedPrice = (fixedPrice > 9 ? fixedPrice : '0' + fixedPrice);	
	}
	return newFixedPrice == 100 ? ((parseInt(priceArr[0]) + 1) + '.00') : (priceArr[0] + '.' + newFixedPrice);
}
// get countdown time data
function getCoundownTimeData(id, callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackCountdown/getOneMlbackCountdownDetail',
		data: JSON.stringify({
			"countdownId": id
		}),
		type: "post",
		dataType: 'json',
		contentType: 'application/json',
		success: function (data) {
			if (data.code == 100) {
				var resData = data.extend.mlbackCountdownOne;
				if (resData) {
					callback && callback(resData);
				}
			} else {
				renderErrorMsg(prodcutBox, 'No product-related data was obtained.');
			}
		}
	});
}
// render coundown time
function rednerCountDownAreaOne(data) {
	if (data.countdownStatus) {
		var html = '';
		html += '<div class="title">' + data.countdownTitle + '</div>' +
			'<div class="body"></div>' +
			'<div class="desc">' + data.countdownDescription + '</div>';
		$('#countdown-area').html(html);
	
		if ((!data.countdownStarttime && !data.countdownEndtime) || (data.countdownStarttime == data.countdownEndtime)) {
			var date = new Date();
			var ymd = date.getFullYear() + '-' + (date.getMonth() + 1 > 9 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1)) + '-' + (date.getDate() > 9 ? date.getDate() : '0' + date.getDate());
			data.countdownStarttime = ymd + ' ' + (date.getHours() > 9 ? date.getHours() : '0' + date.getHours()) + ':' + (date.getMinutes() > 9 ? date.getMinutes() : '0' + date.getMinutes()) + ':' + (date.getSeconds() > 9 ? date.getSeconds() : '0' + date.getSeconds());
			data.countdownEndtime = ymd + ' 23:59:59';
		}

		var countdown = new countDown('#countdown-area .body', {
			start: {
				time: data.countdownStarttime
			},
			end: {
				time: data.countdownEndtime
			},
			format: 'DD : HH : MM : SS',
			themeClass: 'dark',
			interval: 1000,
			stateText: {
				before: 'Start of distance activity:',
				progress: 'End of distance activity:',
				after: 'The activity is over:',
			}
		});
	
		if (countdown && countdown.state == 'after') {
			$('#countdown-area').addClass('hide');
		}		
	}
}
</script>
