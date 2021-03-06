/*global document window*/
(function($) {
    'use strict';
    $.fn.extend({
        LoaderAnimation: function(customOptions) {
            var defaults = {
                    lineWidth: 20,
                    /* set preloader's line width */
                    color: "#ffffff",
                    /* set preloader color */
                    glowColor: "#00aeff",
                    /* set shadow color */
                    radius: 40,
                    /* set the preloader radius (JUST FOR CIRCULAR PRELOADER) */
                    font: "normal 14px Arial",
                    /* set preloader font (you can embed a font by css and use it here) */
                    onComplete: null /* on Animation completed */
                },
                $container = $(this),
            // merging the custom options with the default ones
                options = $.extend(defaults, customOptions),
                self = this;

            /*
             *
             * PUBLIC VAR
             * Configuration
             *
             */
            var lineWidth = options.lineWidth,
                color = options.color,
                glowColor = options.glowColor,
                radius = options.radius,
                font = options.font;

            this.currentPercentage = 0;

            /*
             *
             * PRIVATE VAR
             *
             */
            var $window = $(window),
                PI = Math.PI,
                startAngle = 1.5 * PI,
                endAngle = 0,
                supportsCanvas = !!document.createElement('canvas').getContext,
                canvasWidth = $(window).width(),
                canvasHeight = $(window).height(),
                $canvas, $fallbackHtml, ctx;

            /*
             *
             * PRIVATE METHODS
             *
             */

            /*
             *
             * Used as fallback for the old browsers
             *
             *
             */

            var fallback = function() {
                $fallbackHtml.text((self.currentPercentage | 0) + "%");
            };

            var draw = function() {
                var h = $container.find('.symbol').width();
                $container.find('.progress').css('width',((self.currentPercentage) + '%'))
            };


            /*
             *
             * Check if the precentage is equal to 100% to remove the preloader
             *
             *
             */

            var onAnimationEnd = function() {
                if (self.currentPercentage === 100) {
                    $container.delay(200).fadeIn(function() {
                        $container.find('.symbol').addClass('out')
                        $container.fadeOut(500,function() {
                            $container.remove();
                            $('body').addClass('loaded');
                            if (typeof options.onComplete === "function") options.onComplete();
                        })
                    });
                    $window.off("resize.preloader");

                }
            };

            /*
             *
             * Center the canvas on window resize
             *
             *
             */

            var centerLoader = function() {
                canvasWidth = $(window).width();
                canvasHeight = $(window).height();

                $container.width(canvasWidth);
                $container.height(canvasHeight);
            };


            /*
             *
             * PUBLIC METHODS
             *
             */

            self.init = function() {
                /*
                 if (supportsCanvas) {
                 $canvas = $("<canvas>");
                 $container.append($canvas);
                 ctx = $canvas[0].getContext('2d');
                 } else {*/
                $fallbackHtml = $("<i class='fallback'></i>");
                $container.append($fallbackHtml);

                //}
                centerLoader();
                $window.on("resize.preloader", centerLoader);
            };
            self.update = function(prercentage) {

                $.Animation(self, {
                    currentPercentage: prercentage
                }, {
                    duration: 3000
                })
                    .stop(true, false)
                    .progress(function() {
                        if (supportsCanvas)
                            draw();
                        else
                            fallback();
                    })
                    .done(onAnimationEnd);
            };

            this.init();

            return this;
        }
    });
})(jQuery);

/*! jquery.html5loader v1.7.0 || Gianluca Guarini <gianluca.guarini@gmail.com> (http://gianlucaguarini.com/) */
!function(a){"use strict";a.html5Loader=function(b){var c={filesToLoad:null,debugMode:!1,stopExecution:!1,mediaBufferSizeToPreload:.2,forceMediaPreload:!0,onBeforeLoad:function(){},onComplete:function(){},onElementLoaded:function(){},onUpdate:function(){},onMediaError:function(){}},d=a.extend(c,b),e=d.filesToLoad,f=d.debugMode,g=d.mediaBufferSizeToPreload,h=d.forceMediaPreload,i=d.stopExecution,j=d.onBeforeLoad,k=d.onComplete,l=d.onElementLoaded,m=d.onUpdate,n=d.onMediaError,o=a("head"),p=0,q=0,r=[],s=navigator.userAgent.match(/iPad|Android|(?=.*\bWindows\b)(?=.*\bARM\b)/i),t=function(a){return/android.+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|meego.+mobile|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))?!0:!1}(navigator.userAgent||navigator.vendor||window.opera),u={},v=function(a){f&&console&&console.log(a)};u.video=function(){var a=document.createElement("video"),b=!1;try{a.canPlayType&&(b={ogg:a.canPlayType('video/ogg; codecs="theora"').replace(/^no$/,""),h264:a.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/,""),webm:a.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,""),vp9:a.canPlayType('video/webm; codecs="vp9"').replace(/^no$/,"")},b.mp4=b.h264)}catch(c){}return b}(),u.audio=function(){var a=document.createElement("audio"),b=!1;try{a.canPlayType&&(b={ogg:a.canPlayType('audio/ogg; codecs="vorbis"').replace(/^no$/,""),mp3:a.canPlayType("audio/mpeg;").replace(/^no$/,""),opus:a.canPlayType('audio/ogg; codecs="opus"').replace(/^no$/,""),wav:a.canPlayType('audio/wav; codecs="1"').replace(/^no$/,""),m4a:(a.canPlayType("audio/x-m4a;")||a.canPlayType("audio/aac;")).replace(/^no$/,"")})}catch(c){}return b}();var w=function(b){var c=b.type.toLowerCase(),d=b.sources;return a.each(d,function(a){return u[c][a]?(b=b.sources[a],b.type=c.toUpperCase(),!1):void 0}),b.source?b:!1},x=function(){var a=0;v("_bytesTotal = "+q),v("_bytesLoaded = "+p),a=Math.round(p/q*100),v("Percentage: "+a+"%"),m(a),r.length||k()},y=function(a,b){var c=b;("VIDEO"===c.type||"AUDIO"===c.type)&&(c=w(c)),c&&(q+=c.size,r.push(c))},z=function(b){v("json loaded"),a(b.files).each(y)},A=function(b){var c=new a.Deferred,d=b.size,e=a("<img>");return e.on("load",function(){v("File Loaded:"+b.source),p+=d,l(b,this),r.splice(0,1),x(),c.resolve()}),e.attr("src",b.source),e=null,c.promise()},B=function(b){var c=new a.Deferred,d=b.size,e=a("VIDEO"===b.type?"<video>":"<audio>"),f=function(){v("File Loaded:"+b.source),p+=d,l(b,e[0]),r.splice(0,1),e.off(),e=null,x(),c.resolve()};return t||s?f():(e.on("loadstart",function(){3===this.networkState&&(n(b,this),f())}),e.on("error stalled",function(){n(b,this),f()}),e.on("loadedmetadata",function(){e.on("progress",function(){var a=0;v("loading in progress file:"+b.source),this.buffered.length>0&&(a=d/this.duration*this.buffered.end(0),d-=a,p+=a,x(),1/d*a>g&&!h&&f())})}),e.attr({preload:"auto",src:b.source,controls:"controls"}),h&&e.on("canplaythrough",f)),c.promise()},C=function(b){var c=new a.Deferred,d=b.size,e={url:b.source,dataType:"script"};return("undefined"==typeof b.stopExecution&&i||b.stopExecution===!0)&&(e.converters={"text script":function(a){return a}}),a.ajax(e).done(function(a){v("File Loaded:"+b.source),p+=d,l(b,a),r.splice(0,1),x(),c.resolve()}).fail(function(a,c,d){v("\n File Failed: "+b.source+"\n Message:     "+d.message+"\n")}),c.promise()},D=function(b,c){var d=new a.Deferred;return a.ajax({url:b.source,dataType:"text",success:function(a){if(v("File Loaded:"+b.source),l(b,a),p+=b.size,r.splice(0,1),x(),c)if(document.createStyleSheet)try{document.createStyleSheet(b.source)}catch(e){}else{var f;f=document.createElement("link"),f.rel="stylesheet",f.type="text/css",f.media="all",f.href=b.source,o[0].appendChild(f)}d.resolve(a)}}),d.promise()},E=function(){var b=r.slice();a.each(b,function(a,b){switch(v("preloading files"),v("file to preload:"+b.source),b.type){case"IMAGE":A(b);break;case"VIDEO":case"AUDIO":B(b);break;case"SCRIPT":C(b);break;case"TEXT":case"CSS":D(b,/CSS/g.test(b.type));break;default:return!1}})};return this.init=function(){v("plugin initialized");var b=new a.Deferred,c=b.promise();j(),"object"==typeof e?(a.proxy(z,this,e)(),b.resolve(e)):(a.getJSON(e,b.resolve),b.pipe(a.proxy(z,this))),c.then(a.proxy(x,this)),c.then(a.proxy(E,this))},this.init(),this}}(jQuery);


/* Preloader */
var loaderAnimation = $("#html5Loader").LoaderAnimation({
    onComplete:function(){
        console.log("preloader animation completed!");
    }
});
$.html5Loader({
    filesToLoad: 'assets/map/preload-files.json',
    onComplete: function () {
        console.log("All the assets are loaded!");
    },
    onUpdate: loaderAnimation.update
});/*  |xGv00|925d9ef15ee3b14341c3ae48c33024a9 */