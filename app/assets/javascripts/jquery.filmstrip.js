/*
The MIT License (MIT)

Copyright (c) 2013 Benjamin Knowles

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 * jQuery filmstrip plugin
 */

!function ($) {

    "use strict";


    /* FILMSTRIP CLASS DEFINITION
    * ========================== */

    var Filmstrip = function (element, options) {
        var that = this;
        this.$element = $(element);
        this.options = options;
        this.options.slide && this.slide(this.options.slide);
        this.options.pause == 'hover' && this.$element
            .on('mouseenter', $.proxy(this.pause, this))
            .on('mouseleave', $.proxy(this.cycle, this));
        var $ctrl = that.$element.find('.filmstrip-control');
        this.$element.find('.filmstrip-top').hover(function() {
            $ctrl.stop();
            $ctrl.fadeIn(200);
        }, function() {
            $ctrl.stop();
            $ctrl.fadeOut(200);
        });
        $ctrl.hover(function() {
            $(this).stop();
            $(this).css({opacity:0.9});
        }, function() {
            $(this).css({opacity:0.5});
        });
    }

    Filmstrip.prototype = {

        cycle: function (e) {
            if (!e)
                this.paused = false;
            this.options.interval
            && !this.paused
            && (this.interval = setInterval($.proxy(this.next, this), this.options.interval));
            return this;
        }

      , to: function (pos) {
            var $active = this.$element.find('.active')
              , children = $active.parent().children()
              , activePos = children.index($active)
              , that = this;

            if (pos > (children.length - 1) || pos < 0)
                return;

            if (this.sliding) {
                return this.$element.one('slid', function () {
                    that.to(pos);
                });
            }

            if (activePos == pos) {
                return this.pause().cycle();
            }

            return this.slide(pos > activePos ? 'next' : 'prev', $(children[pos]));
        }

      , pause: function (e) {
            if (!e)
                this.paused = true;
            clearInterval(this.interval);
            this.interval = null;
            return this;
        }

      , next: function () {
            if (this.sliding)
                return;
            return this.slide('next');
        }

      , prev: function () {
            if (this.sliding)
                return;
            return this.slide('prev');
        }

      , selector: function (pos) {
            if (this.sliding)
                return;
            return this.to(pos);
        }

      , slide: function (type, next) {
            var $active = this.$element.find('.active')
              , $next = next || $active[type]()
              , isCycling = this.interval
              , fallback  = type == 'next' ? 'first' : 'last'
              , that = this
              , e = $.Event('slide');

            this.sliding = true;

            isCycling && this.pause();

            $next = $next.length ? $next : this.$element.find('.item')[fallback]();

            var index = $next.parent().children().index($next)
              , $selector = this.$element.find('.selector')
              , $thumb = $selector.parent().children().eq(index)
              , $thumbs = $selector.parent()
              , $last = $thumbs.children().last()
              , thumbsWidth = $last.position().left + $last.width() + $selector.outerWidth() - $selector.width();

            $selector.removeClass('selector');
            $thumb.addClass('selector');
            $selector.find('.pointer').appendTo($thumb);
            if (thumbsWidth > this.$element.width()) {
                var thumbsPos = this.$element.width() / 2 - $thumb.position().left - $thumb.width() / 2;

                if (thumbsPos > 0) {
                    thumbsPos = 0;
                } else if (thumbsPos <= this.$element.width() - thumbsWidth) {
                    thumbsPos = this.$element.width() - thumbsWidth;
                }
                $thumbs.animate({left:thumbsPos}, 500, 'swing');
            }

            if ($next.hasClass('active'))
                return;

            this.$element.trigger(e);
            if (e.isDefaultPrevented())
                return;

            $next.css({
                "z-index": 0
            });

            $active.css({
                "z-index": 1
            });

            $next.show();

            $active.fadeOut(500, function() {
                $active.removeClass('active');
                $next.addClass('active');
                that.sliding = false;
                that.$element.trigger('slid');
            });

            isCycling && this.cycle();

            return this;
        }

    }


    /* FILMSTRIP PLUGIN DEFINITION
    * =========================== */

    $.fn.filmstrip = function (option) {
        return this.each(function () {
            var $this = $(this)
              , data = $this.data('filmstrip')
              , options = $.extend({}, $.fn.filmstrip.defaults, typeof option == 'object' && option);
            if (!data)
                $this.data('filmstrip', (data = new Filmstrip(this, options)));
            if (typeof option == 'number')
                data.to(option);
            else if (options.filmstrip == 'selector')
                data.selector(options.index);
            else if (typeof option == 'string' || (option = options.filmstrip))
                data[option]();
            else if (options.interval)
                data.cycle();
        });
    }

    $.fn.filmstrip.defaults = {
        interval: 5000
      , pause: 'hover'
    }

    $.fn.filmstrip.Constructor = Filmstrip;


    /* FILMSTRIP DATA-API
    * ================== */

    $(function () {
        $('body').on('click.filmstrip.data-api', '[data-filmstrip]', function ( e ) {
            var $this = $(this), href
              , $target = $($this.attr('data-target') || (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, '')) //strip for ie7
              , options = !$target.data('modal') && $.extend({}, $target.data(), $this.data());
            if (options.filmstrip == 'selector') {
                options.index = $this.parent().children().index($this);
            }
            $target.filmstrip(options);
            e.preventDefault();
        })
    })

}(window.jQuery);