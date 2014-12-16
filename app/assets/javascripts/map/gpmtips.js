var gpmtips = (function() {
	var d = document,
	nu = navigator.userAgent.toLowerCase(),
	ie = nu.indexOf("msie") != -1,
	bv = (nu.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [0, '0'])[1],
	ie7 = ie && bv.substr(0, 1) == '7',
	ie6 = ie && bv.substr(0, 1) == '6',
	opera = nu.indexOf("opera") != -1,
	dt = new Date(),
	api='http://apps.game.qq.com/client_pop/api.php?',
	//api = 'http://v_gjyang.qq.com/frontend/api.php?',
	cssapi = 'http://ossweb-img.qq.com/images/clientpop/css/cf.css',
	apicfg = 'http://apps.game.qq.com/client_pop/tpl/webtips/',
	//apicfg = 'http://v_gjyang.qq.com/frontend/js/',
	apijson = 'http://ossweb-img.qq.com/images/clientpop/js/json.js',
	game = '',
	games = new Array('cf', 'wf', 'nz', 'lol', 'xy', 'woz', 'ava', 'x5', 'dj2', 'dzs', 'speed', 'nba2k', 'dnf', 'bns', 'smite', 'codo','codol'),
	cn = 'ractWrap',
	ckpre = 'gpmtips',
	ckact = ckpre + '_data',
	ckcfg = ckpre + '_cfg',
	ckhour = 240,
	ckhouro = 60 * 24 * 365,
	ckhourd = 60 * 24 * 14,
	folder = 2
	function doAds() {
		if (typeof TgWebtipsGPMAds != 'undefined' && TgWebtipsGPMAds.iRet == 0) {
			var ad = TgWebtipsGPMAds.data;
			var _ad = new Array();
			var _j = -1;
			if (ad instanceof Array) {
				for (var i = 0; i < ad.length; i++) {
					_ad.push({
						id: ad[i].actId,
						url: ad[i].url,
						value: '0,0'
					});
					if (chkHara(ad[i].actId)) {
						_j=i
					}
				}
				sCookie(ckact, JSON.stringify(_ad), ckhour);
				if (_j==-1) {
					renAds(_ad[Math.floor(Math.random()*_ad.length+1)-1], true)
				} else {
					renAds(_ad[_j], false)
				}
			}
		}
	}
    function IsPC()
    {	
        var userAgentInfo = navigator.userAgent;
        var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod");
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }
        }	
        return flag;
    }
	function renAds(data, hide) {
		if (data) {
			var div = d.createElement("div");
			var ifr = d.createElement('iframe');
			var box = '<div class="ract-content" id="ractBox" style="' + (hide ? "display:none;": "") + '">';
			box += '<a class="collapse" title="关闭" href="javascript:gpmtips.init(' + "'cl'" + ',true);">关闭</a>';
			box += '</div>';
			var close = '<a class="expand" id="expandBtn" href="javascript:gpmtips.init(' + "'op'" + ',true);" style="display:' + (hide ? "block": "none") + ';">' + game.toUpperCase() + '活动推荐</a>'
			div.id = cn;
			div.className = 'ract-box';
			div.innerHTML = close + box;
			d.body.appendChild(div);
			ifr.src = data.url + '?url=' + window.location;
			ifr.id = 'ractIfr';
			ifr.name = 'ractIfr';
			ifr.className = 'ract-ifr';
			ifr.setAttribute('data', data.id);
			ifr.setAttribute('frameborder', "no",0);
			ifr.setAttribute('border', "no");
			ifr.setAttribute('scrolling', "no");
			ifr.onload = function() {};
			getelm('ractBox').appendChild(ifr);
			var actpop = data.value;
			var popupdate = false;
			if (actpop) {
				var actpopArr = actpop.split(',');
				if (!hide && actpopArr.length == 2) {
					uCookie(data.id, 'value_p', 1);
					popupdate = true;
				} else if (hide) {
					popupdate = true;
				}
			}
			if (!popupdate) {
				uCookie(data.id, 'value', '1,0');
			}
			if (hide) {
				resetcss(true);
			} else {
				r('pop', data.id);
				resetcss(false);
			}
			if (ie6) {
				//pos();
				ade(window, "scroll", pos);
				ade(window, "resize", pos);
			}
		}
	}
	function uCookie(id, k, v, m) {
		var _ckact = gCookie(ckact);
		if (_ckact) {
			_ckact = JSON.parse(_ckact) 
			for (var i = 0; i < _ckact.length; i++) {
				if (_ckact[i].id == id) {
					if (m & k == 'value') {
						var _v = _ckact[i].value.split(',');
						_ckact[i].value = _v[0] + ',' + (pi(_v[1]) + v);
					} else {
						if (k == 'value') {
							_ckact[i].value = v;
						} else if (k == 'value_p') {
							var _v = _ckact[i].value.split(',');
							_ckact[i].value = (pi(_v[0]) + v) + ',' + _v[1];
							if ((pi(_v[0]) + v) >= folder) {
								updateHara(id);
							}
						} else if (k == 'url') {
							_ckact[i].url = v
						}
					}
				}
			}
			sCookie(ckact, JSON.stringify(_ckact));
		}
	}
	function getAds() {
		var _ckact = gCookie(ckact);
		_ckact = _ckact ? JSON.parse(_ckact) : '';
		if (_ckact instanceof Array && _ckact.length) {
			var _j = -1;
			var _v = -1;
			var _folder= -1;
			for (var i = 0; i < _ckact.length; i++) {
				if (_ckact[i].value) {
					var _pop = _ckact[i].value.split(',');
					//在到达收起次数之前，自动去展示最少那个来展示
					if (_pop.length == 2 && _pop[0]<folder && chkHara(_ckact[i].id)) {
						if (_v==-1) {
							_v=_pop[0]
							_j=i
						} else {
							if(_pop[0]<_v) {
								_v=_pop[0]
								_j=i
							}
						}
					}
				}
			}
			if (_j==-1) {
				//都达到收起次数，随机取一个展示 -只要到达收起次数肯定设置防骚扰
				renAds(_ckact[Math.floor(Math.random()*_ckact.length+1)-1], true)
			} else {
				renAds(_ckact[_j], false);
			}
			return;
		} else {
			ls(api + 'action=doWebtipsJudge&iUin=' + getuin() + '&sServiceType=' + game, doAds);
		}
	}
	//如果活动两周内已经到达收起，以后不再自动展开
	function chkHara(id) {
		var _ckacto = gCookie(ckact + '_o');
		_ckacto = _ckacto ? JSON.parse(_ckacto) : '';
		if (_ckacto instanceof Array && _ckacto.length) {
			for (var i = 0; i < _ckacto.length; i++) {
				if (_ckacto[i].id == id && Math.round(new Date().getTime()/1000) < _ckacto[i].valid) {
					return false;
				}
			}
		}
		return true;
	}
	
	function updateHara(id) {
		var _ckacto = gCookie(ckact + '_o');
		_ckacto = _ckacto ? JSON.parse(_ckacto) : '';
		var _exist = false;
		var _vt = Math.round(new Date().getTime()/1000) + (ckhourd * 60)
		if (_ckacto instanceof Array && _ckacto.length) {
			for (var i = 0; i < _ckacto.length; i++) {
				if (_ckacto[i].id == id) {
					_ckacto[i].valid = _vt.toString();
					_exist = true;
				}
			}
			if (!_exist) {
				_ckacto.push({
					id: id,
					valid: _vt
				});
			}
		} else {
			_ckacto = [{
				id: id,
				valid: _vt
			}]
		}
		sCookie(ckact + '_o', JSON.stringify(_ckacto), ckhouro);
		return true;
	}
	
	function r(t, id) {
		ls(api + 'action=doWebtipsReport&iUin=' + getuin() + '&sServiceType=' + game + '&op=' + t + '&actId=' + id, dor);
	}
	function dor() {
		if (typeof TgWebtipsGPMReport != 'undefined' && TgWebtipsGPMReport.iRet == 0) {
			var tgr = TgWebtipsGPMReport;
			if (haspro(tgr, 'op') && haspro(tgr, 'actId') && tgr.op == "click" && tgr.actId) {
				uCookie(tgr.actId, 'value', 1, true);
			}
		}
	}
	function resetcss(a) {
		if (getelm('_feedback_layout')) {
			var _css;
			if (a) {
				getelm(cn).className += " ract-feedback";
			} else {
				getelm(cn).className = "ract-box";
			}
		}
	}
	function close() {
		getelm('ractBox').style.cssText = "display:none;";
		getelm('expandBtn').style.cssText = "display:block;";
		resetcss(true);
		if(ie6){pos();}
	}
	function open() {
		getelm('ractBox').style.cssText = "display:block;";
		getelm('expandBtn').style.cssText = "display:none;";
		if(ie6){pos();}
		resetcss(false);
		var _actId = getelm('ractIfr').getAttribute('data');
		r('pop', _actId);
		uCookie(_actId, 'value_p', 1, false);
	}
	function getuin() {
		return gCookie("pt2gguin") ? gCookie("pt2gguin").substr(1).replace(/\b(0+)/gi, "") : '';
	}
	function getelm(id) {
		return "string" == typeof id ? d.getElementById(id) : id
	}
	function pi(i) {return parseInt(i);}
	function haspro(e, key) {
		return e.hasOwnProperty(key);
	}
	function inarr(a, e) {
		var s = String.fromCharCode(2);
		var r = new RegExp(s + e + s);
		return (r.test(s + a.join(s) + s));
	}
	function sCookie(name, value, e) {
		var dt = new Date();
		var e = arguments[2] || ckhour;
		if (e) {
			dt.setMinutes(dt.getMinutes() + pi(e));
		}
		var cookietemp = escape(name) + '=' + escape(value) + (e ? ';path=/;expires=' + dt.toGMTString() : '');
		d.cookie = cookietemp;
	}
	function gCookie(name) {
		var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
		if (arr = d.cookie.match(reg)) {
			return unescape(arr[2])
		} else {
			return ''
		}
	}
	function loadStyle(url, fn) {
		var h = d.getElementsByTagName('HEAD').item(0);
		var s = d.createElement("link");
		s.rel = 'stylesheet';
		s.type = 'text/css';
		s.media = 'all';
		s.href = url;
		h.appendChild(s);
	}
	function ade(obj, evt, fn) {
		if (obj.addEventListener) {
			obj.addEventListener(evt, fn, false);
		} else if (obj.attachEvent) {
			obj.attachEvent('on' + evt, fn);
		}
	}
	function pos() {
		var _fh = 0;
		if (getelm('_feedback_layout')) {
			_fh = 23;
		}
		if (ie6) {
			_fh = 0;
		}
		getelm(cn).style.top = d.documentElement.scrollTop + d.documentElement.clientHeight - getelm(cn).offsetHeight - 2 - _fh + "px";
	}
	function ls(url, callback, charset) {
		var script = document.createElement("script");
		script.type = "text/javascript";
		if (charset) {
			script.setAttribute("charset", charset);
		}
		if (script.readyState) {
			script.onreadystatechange = function() {
				if (script.readyState == "loaded" || script.readyState == "complete") {
					script.onreadystatechange = null;
					callback();
					document.getElementsByTagName("head")[0].removeChild(this);
				}
			};
		} else {
			script.onload = function() {
				callback();
				document.getElementsByTagName("head")[0].removeChild(this);
			};
		}
		script.src = url;
		document.getElementsByTagName("head")[0].appendChild(script);
	}
	function doCfg() {
		if (typeof config != 'undefined') {
			if (haspro(config, 'iShowCount') && haspro(config, 'iSendApi') && haspro(config, 'iOnlineCount')) {
				sCookie(ckcfg, JSON.stringify(config));
				if(pi(config.iOnlineCount)>0) {
					if (pi(config.iShowCount)) {
						folder = pi(config.iShowCount);
					}
					if (pi(config.iSendApi)) {
						ckhour = pi(config.iSendApi);
					}
					getAds();
				}
			}
		}
	}
	function doInit() {
		game = location.hostname.replace('.qq.com', '');
		//game = "cf";  //线上请注释这行
		if (!inarr(games, game)) {
			return;
		}
        if( !IsPC() ){
            return;
        }
        //http://cf.qq.com/act/a20141211pop/ 不弹框
	var noPopUrl = window.location.href;
	var actName = noPopUrl.replace('http://cf.qq.com/','');
	actName = actName.split('/');
	if(actName[1] == 'a20141211pop'){
	    return;
        }
		//apicfg = apicfg + game + 'WebtipsSystemConfig.js';
		apicfg = apicfg + game + 'WebtipsSystemConfig.js?r='+Math.random();
		loadStyle(cssapi);
		ls(apicfg, doCfg);
	}
       setTimeout(function(){ls('http://ossweb-img.qq.com/images/clientpop/js/history/gpmhistory.js',function(){});},3000)
	return {
		init: function(a, t) {
			if (!a) {
				//if (!ie6 && !ie7) {
				if (typeof(JSON)=='object') {
					if(typeof JSON.stringify!=='function' || typeof JSON.parse!=='function') {
						ls(apijson, doInit);
					} else {
						doInit();
					}
					
				} else {
					ls(apijson, doInit);
				}
			} else if (a == 'cl') {
				close();
			} else if (a == 'op') {
				open();
			} else if (a.indexOf('.') > 0) {
				r('click', t);
			}
		}
	}
})();
gpmtips.init()
/*  |xGv00|9ab11425c460c1a3542503a703cad084 */