window.isMobile=/mobile/i.test(navigator.userAgent);
var parallax;
$(document).ready(function(){
    var ie8=document.all&&!document.addEventListener;$('.poi_thumb').on('click',function(){if($(this).prop('hash')===location.hash)$(window).trigger('hashchange');});initDropdown();if(!ie8){var scene=document.getElementById('scene');parallax=new Parallax(scene);}
    $('.js-close-intro').on('click',function(e){$('.landing').fadeOut(1000,function(){
        $('body').addClass('intro-hidden');$(window).trigger('resize')
        var $clicked=$(this);
        $('#poi-carousel').removeClass('hidden').owlCarousel({loop:false,dots:false,margin:0,items:4,slideBy:3,nav:true,responsive:{768:{items:4},930:{items:5},1116:{items:6},1302:{items:7},1488:{items:8},1674:{items:9},1860:{items:10},2046:{items:11}},navText:["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"]});
        if(!ie8){parallax.disable();}});if($(this).attr('href')=="")e.preventDefault();});$('.btn-intro').html(intro_text[Math.floor(intro_text.length*Math.random())]);if(current_point&&$('.landing:visible')){location.hash='';$('.landing').hide();current_point.marker.openPopup();current_point.marker.fireEvent('popupopen');}});$(window).load(function(){map.fireEvent('move');});var panning=false;var current_point;$('body').toggleClass('dropdown-active');$('.btn-nav').find('i').toggleClass('hidden');function initDropdown(){$('.btn-nav').click(function(){$(window).trigger('resize')
        var $clicked=$(this);$clicked.find('i').toggleClass('hidden');$('body').toggleClass('dropdown-active');$('#poi-carousel').removeClass('hidden').owlCarousel({loop:false,dots:false,margin:0,items:4,slideBy:3,nav:true,responsive:{768:{items:4},930:{items:5},1116:{items:6},1302:{items:7},1488:{items:8},1674:{items:9},1860:{items:10},2046:{items:11}},navText:["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"]});});
        $(window).on('hashchange',function(){
            var new_id=location.hash.slice(1);
            var point;
            if(new_id&&(point=get_poi(location.hash.slice(1))).type)
            //change this and I'll be happy
            {
                $('.btn-nav').trigger('click');panning=true;
                current_point=point;
                if(point.anchor&&point.anchor=="top"){
                    point.offset=$.extend({},poi_defaults.offset);point.offset.y+=420;current_point.flipped=true;
                }
                else{current_point.flipped=false;}
                var pixelPosition=map.project(point.position);
                var new_position=map.unproject([pixelPosition.x+point.offset.x,pixelPosition.y+point.offset.y]);
              

                var distance=map.getCenter().distanceTo(new_position)/5000000;
                map.panTo(new_position,{duration:distance,animate:true});
                if(!$('#map').hasClass('popup-active'))point.openPopup();
            }
            else{
                map.closePopup();$('#fullscreen-container').removeClass('show');}}).trigger('hashchange');}
var poi_defaults={options:{minWidth:500,maxWidth:500,autoPan:false,autoPanPadding:new L.Point(25,25),keepInView:false},openPopup:function(){var point=this;panning=false;if(point.fullscreen)
{var $fullscreen_container=$('#fullscreen-container');$fullscreen_container.addClass('show')
    $fullscreen_container.find('.content').html(point.popup_html);$fullscreen_container.find('.close-button').one('click',function(){point.marker.fireEvent('popupclose');return false;});point.marker.fireEvent('popupopen');}else{point.marker.openPopup();}},closePopup:function(){var point=this;point.marker.closePopup();if(point.fullscreen)
{point.marker.fireEvent('popupclose');}},offset:{x:0,y:-180}};var poi_order=["the-bases","inhibitor-timers","the-murkwolves","gromp","fail-flashes-be-gone","baron-nashor","four-quadrants","the-raptors","destructible-structures","blue-sentinel","dragon","the-krugs","red-brambleback"];function get_poi(id){return poi[id]&&$.extend({},poi_defaults,poi[id]);}
function set_poi_props(id,props){poi[id]=$.extend(poi[id],props);}
var markers={'default':L.icon({iconUrl:'assets/map/pin_new.png',iconSize:[38,54],iconAnchor:[18,54],popupAnchor:[3,4],shadowUrl:'/assets/map/pin_shadow.png',shadowSize:[82,28],shadowAnchor:[38,10]}),video:L.icon({iconUrl:'/assets/map/pin_video.png',iconSize:[38,54],iconAnchor:[18,54],popupAnchor:[3,4],shadowUrl:'/assets/map/pin_shadow.png',shadowSize:[82,28],shadowAnchor:[38,10]}),monster:L.icon({iconUrl:'/assets/map/pin_monster.png',iconSize:[38,54],iconAnchor:[18,54],popupAnchor:[3,4],shadowUrl:'/assets/map/pin_shadow.png',shadowSize:[82,28],shadowAnchor:[38,10]}),hidden:L.icon({iconUrl:'/assets/map/pin_hidden.png',iconSize:[38,54],iconAnchor:[18,54],popupAnchor:[3,4],shadowUrl:'/assets/map/pin_shadow_hidden.png',shadowSize:[82,28],shadowAnchor:[38,10]})};
var map_asset_url='/assets/map/leaflet';
var maxBounds=L.latLngBounds(L.latLng(-85.0511,-180),L.latLng(40,88));
var map=L.map('map',{zoomControl:false,maxBounds:maxBounds}).setView((location.hash.slice(1)&&get_poi(location.hash.slice(1)).position)||poi["the-bases"].position,5,{crs:L.CRS.Simple});new L.Control.Zoom({position:'bottomright',zoomInTitle:'',zoomOutTitle:''}).addTo(map);L.tileLayer(map_asset_url+'/{z}/{x}/{y}.png',{attribution:"© TGideas -- Powered by smallniding",minZoom:isMobile?2:3,maxZoom:5,tms:true,noWrap:true,animate:true,unloadInvisibleTiles:false,errorTileUrl:map_asset_url+'/empty.png',bounds:maxBounds}).addTo(map);
var base_minimap_size={'x':193,'y':162};
function minimapCoordsToMapCoords(elem,event){
    var $elem=$(elem);
    var offset=$elem.offset();
    var height=$elem.height();
    var width=$elem.width();
    return[base_minimap_size.x*(event.clientX-offset.left)/width,base_minimap_size.y*(event.clientY-offset.top+height*.56)/height];
}
function mapCoordsToMinimapCoords(elem,map_coord){
    var $elem=$(elem);
    var height=$elem.height();
    var width=$elem.width();
    return[width*map_coord.x/base_minimap_size.x,height*map_coord.y/base_minimap_size.y-(height*.56)];
}
var pan={shouldUpdate:false,to:null,offset:0,total_requests:0};
function updatePan(){
    if(pan.to&&pan.total_requests>5){
        map.panTo(pan.to);
        pan.total_requests=0;
    }else{pan.total_requests++;}
    pan.to=null;
};
var Minimap=L.Control.extend({options:{position:'bottomright'},onAdd:function(map){var built_minimap=HTML('div',{'class':'leaflet-control-minimap'},[HTML('img',{'class':'leaflet-control-minimap-image','src':'/assets/map/minimap_small.jpg'}),HTML('div',{'class':'leaflet-control-minimap-reticule'},[HTML('div',{'class':'leaflet-control-minimap-reticule-fill'})]),HTML('a',{'class':'leaflet-control-minimap-toggle-display','href':'javascript:void(\'Hide MiniMap\')','title':'隐藏小地图'})]);return built_minimap;}});
map.addControl(new Minimap);
$('.leaflet-control-minimap').on('click',function(event){if(1===event.which){map.panTo(map.unproject(minimapCoordsToMapCoords(this,event),0),{animate:true,delay:.5});}return false;}).on('dblclick',function(event){return false;}).on('mousedown',function(event){if(1!==event.which)return false;var $this=$(this);pan.shouldUpdate=true;$(window).one('mouseup',function(){$('.leaflet-control-minimap, .leaflet-tile-container').trigger('mouseup');});updatePan();$this.on('mousemove',function(event){var coords=minimapCoordsToMapCoords(this,event)
    pan.to=map.unproject(coords,0);
    setMinimapReticule(L.point(coords));
    if(pan.shouldUpdate)updatePan();});return false;}).on('mouseup',function(){$(this).off('mousemove');pan.shouldUpdate=false;return false;});
function setMinimapReticule(position_override){
    if(pan.shouldUpdate&&!(position_override instanceof L.Point))return;
    var $minimap=$('.leaflet-control-minimap');
    var minimap_width=$minimap.width();
    var minimap_height=$minimap.height();
    var coords=pan.shouldUpdate?position_override:map.project(map.getCenter(),0);
    var center=mapCoordsToMinimapCoords($minimap[0],coords);
    var latBounds=map.getBounds();
    var bounds={'southWest':mapCoordsToMinimapCoords($minimap[0],map.project(latBounds._southWest,0)),'northEast':mapCoordsToMinimapCoords($minimap[0],map.project(latBounds._northEast,0))};
    var width=Math.abs(bounds.southWest[0]-bounds.northEast[0]);
    var height=Math.abs(bounds.southWest[1]-bounds.northEast[1]);
    var position={'left':center[0]-width/2,'top':center[1]-height/2};
    if(position.left<0)position.left=0;
    else position.left=Math.min(position.left,minimap_width-width);
    if(position.top<0)position.top=0;
    else position.top=Math.min(position.top,minimap_height-height);
    $('.leaflet-control-minimap-reticule').css({'left':position.left/minimap_width*100+'%','top':position.top/minimap_height*100+'%','width':Math.min(width,minimap_width-position.left)/minimap_width*100+'%','height':Math.min(height,minimap_height-position.top)/minimap_height*100+'%'});
};
map.on('move',setMinimapReticule).on('zoomend',setMinimapReticule);
$('.leaflet-control-minimap-toggle-display').on('click',function(){$(this).add('.leaflet-control-minimap-image').toggleClass('minimized');return false;});
var popup_partials={
    guide:function(current_id){
        var current_index=poi_order.indexOf(current_id);
        if(-1!==current_index){
            return HTML('div',{'class':'leaflet-tour'},[HTML('a',{'class':'leaflet-tour-prev fa fa-chevron-left',href:'#'+(poi_order[current_index-1]||'')}),HTML('a',{'class':'leaflet-tour-next fa fa-chevron-right',href:'#'+(poi_order[current_index+1]||'')})]);
        }
        else return HTML('div',{'class':'leaflet-tour'});}
};
var buildPopup={
        monster:function(popup,id){return HTML('div',null,[HTML('div',{'class':'leaflet-title-wrapper'},HTML('h4',{'class':'leaflet-title'},popup.title)),HTML('div',{'class':'video-container'},HTML('div',{'id':"videobBox"+id},'<object width="480" height="300" id="video_'+id+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codeBase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=10,0,0,0"><param name="movie" value="http://imgcache.qq.com/tencentvideo_v1/player/TPout.swf?autoplay=0&amp;outhost=http://lol.qq.com/&amp;skin=http://imgcache.qq.com/minivideo_v1/vd/res/skins/TencentPlayerMiniSkin.swf&amp;vid='+popup.src+'"><param name="wmode" value="opaque"><param name="allowscriptaccess" value="always" /><param name="quality" value="high"><param name="allowfullscreen" value="true"><param name="allownetworking" value="all"><embed width="480" height="300" align="middle" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" id="_playerswf'+id+'" name="_playerswf'+id+'" quality="high" src="http://imgcache.qq.com/tencentvideo_v1/player/TPout.swf?autoplay=0&amp;outhost=http://lol.qq.com/&amp;skin=http://imgcache.qq.com/minivideo_v1/vd/res/skins/TencentPlayerMiniSkin.swf&amp;vid='+popup.src+'" wmode="opaque"></object>')),HTML('div',{'class':'leaflet-content'},[HTML('p',null,popup.description)]),popup_partials.guide(id)]);},
        'default':function(popup,id){return HTML('div',null,[HTML('div',{'class':'leaflet-content'},[HTML('div',{'class':'leaflet-title-wrapper'},HTML('h4',{'class':'leaflet-title'},popup.title)),HTML('p',null,popup.description)]),popup_partials.guide(id)]);},
        hidden:function(popup,id){return HTML('div',null,[HTML('div',{'class':'leaflet-content'},[HTML('div',{'class':'leaflet-title-wrapper'},HTML('h4',{'class':'leaflet-title'},popup.title)),HTML('p',null,popup.description)]),popup_partials.guide(id)]);}
    };

//change this and I'll be happy
Object.keys(poi).forEach(function(id){
    var point=get_poi(id);
    set_poi_props(id,{marker:L.marker(point.position,{icon:markers[point.type]}),popup_html:buildPopup[point.type](point.popup,id)});
    poi[id].marker.on('popupopen',
        function(event,fullscreen){
            $('.leaflet-control-minimap .overlay').remove();
            $('.btn-nav').click();$('#map').addClass('popup-active');
            location.hash=id;
            var point=get_poi(id);
            if(point.anchor=="top"){$('.leaflet-popup').addClass('flip');}
            else{$('.leaflet-popup').removeClass('flip');}
            var $minimap=$('.leaflet-control-minimap');
            $minimap.append(HTML('div',{'class':'overlay overlay-'+id}));
        }
    ).on('popupclose',
    function(){
        $('.leaflet-control-minimap .overlay').remove();
        if(location.hash.slice(1)!==id)return;
        if(history&&history.pushState){history.pushState(history.state,document.title,location.href.replace(/#.*/,''))}
        else{location.hash='';}
        $('#map').removeClass('popup-active');
        $('#fullscreen-container').removeClass('show');}).on('click',
        function(){
             var point=get_poi(id);
              if(point.fullscreen)point.openPopup();
        }).addTo(map);
});function on_desktop(){poi_defaults.fullscreen=false;Object.keys(poi).forEach(function(id){var point=get_poi(id);if(!poi[id].fullscreen)
{poi[id].marker.bindPopup(point.popup_html,point.options);}});}
function on_mobile(){poi_defaults.fullscreen=true;Object.keys(poi).forEach(function(id){poi[id].marker.unbindPopup();});}
enquire.register('screen and (max-width:767px)',{match:on_mobile,unmatch:function(){var point=get_poi(location.hash.slice(1));poi_defaults.fullscreen=true;if(point){point.closePopup();}
    poi_defaults.fullscreen=false;}});enquire.register('screen and (min-width:768px)',{match:on_desktop,unmatch:function(){var point=get_poi(location.hash.slice(1));if(point){point.closePopup();}
    map.closePopup();}});if(document.all&&!document.addEventListener)on_desktop();$('#fullscreen-container').on('transitionend',function(){var $this=$(this);if(!$this.hasClass('show'))$this.find('.content').empty();});function HTML(tag,attributes,content){var elem=document.createElement(tag);if(attributes){Object.keys(attributes).forEach(function(attr){elem.setAttribute(attr,attributes[attr]);});}
    $(elem).append(content);return elem;}
var animating=false;map.on('moveend',function(e){if(panning){current_point.openPopup();panning=false;}})/*  |xGv00|ddea2ad420d87dd49dec90045d5c6b0c */