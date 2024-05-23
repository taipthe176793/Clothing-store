var searchVisible = 0;
var transparent = true;
var transparentDemo = true;
var fixedTop = false;
var navbar_initialized = false;
var mobile_menu_visible = 0,
    mobile_menu_initialized = false,
    toggle_initialized = false,
    bootstrap_nav_initialized = false,
    $sidebar, isWindows;
$(document).ready(function() {
    window_width = $(window).width();
    lbd.checkSidebarImage();
    if (window_width <= 991) {
        lbd.initRightMenu();
    }
    $('[rel="tooltip"]').tooltip();
    if ($("[data-toggle='switch']").length != 0) {
        $("[data-toggle='switch']").bootstrapSwitch();
    }
    $('.form-control').on("focus", function() {
        $(this).parent('.input-group').addClass("input-group-focus");
    }).on("blur", function() {
        $(this).parent(".input-group").removeClass("input-group-focus");
    });
    $('body').on('touchstart.dropdown', '.dropdown-menu', function(e) {
        e.stopPropagation();
    });
    if ($('.twitter-sharrre').length != 0) {
        $('.twitter-sharrre').sharrre({
            share: {
                twitter: true
            },
            enableHover: false,
            enabletracking: false,
            enableCounter: false,
            buttons: {
                twitter: {
                    via: 'CreativeTim'
                }
            },
            click: function(api, options) {
                api.simulateClick();
                api.openPopup('twitter');
            },
            template: '<i class="fa fa-twitter"></i>',
            url: 'http://demos.creative-tim.com/light-bootstrap-dashboard/examples/dashboard.html'
        });
    }
    if ($('.twitter-sharrre-nav').length != 0) {
        $('.twitter-sharrre-nav').sharrre({
            share: {
                twitter: true
            },
            enableHover: false,
            enabletracking: false,
            enableCounter: false,
            buttons: {
                twitter: {
                    via: 'CreativeTim'
                }
            },
            click: function(api, options) {
                api.simulateClick();
                api.openPopup('twitter');
            },
            template: '<i class="fa fa-twitter"></i><p class="hidden-lg-up">Twitter</p>',
            url: 'http://demos.creative-tim.com/light-bootstrap-dashboard/examples/dashboard.html'
        });
    }
    if ($('.facebook-sharrre').length != 0) {
        $('.facebook-sharrre').sharrre({
            share: {
                facebook: true
            },
            enableHover: false,
            enabletracking: false,
            enableCounter: false,
            click: function(api, options) {
                api.simulateClick();
                api.openPopup('facebook');
            },
            template: '<i class="fa fa-facebook-square"></i>',
            url: 'http://demos.creative-tim.com/light-bootstrap-dashboard/examples/dashboard.html'
        });
    }
    if ($('.facebook-sharrre-nav').length != 0) {
        $('.facebook-sharrre-nav').sharrre({
            share: {
                facebook: true
            },
            enableHover: false,
            enabletracking: false,
            enableCounter: false,
            click: function(api, options) {
                api.simulateClick();
                api.openPopup('facebook');
            },
            template: '<i class="fa fa-facebook-square"></i><p class="hidden-lg-up">Facebook</p>',
            url: 'http://demos.creative-tim.com/light-bootstrap-dashboard/examples/dashboard.html'
        });
    }
    if ($('.linkedin-sharrre').length != 0) {
        $('.linkedin-sharrre').sharrre({
            share: {
                linkedin: true
            },
            enableCounter: false,
            enableHover: false,
            enabletracking: false,
            click: function(api, options) {
                api.simulateClick();
                api.openPopup('linkedin');
            },
            template: '<i class="fa fa-linkedin"></i>',
            url: 'http://demos.creative-tim.com/light-bootstrap-dashboard/examples/dashboard.html'
        });
    }
    if ($('.linkedin-sharrre-nav').length != 0) {
        $('.linkedin-sharrre-nav').sharrre({
            share: {
                linkedin: true
            },
            enableCounter: false,
            enableHover: false,
            enabletracking: false,
            click: function(api, options) {
                api.simulateClick();
                api.openPopup('linkedin');
            },
            template: '<i class="fa fa-linkedin"></i><p class="hidden-lg-up">LinkedIn</p>',
            url: 'http://demos.creative-tim.com/light-bootstrap-dashboard/examples/dashboard.html'
        });
    }
});
$(window).resize(function() {
    if ($(window).width() <= 991) {
        lbd.initRightMenu();
    }
});
lbd = {
    misc: {
        navbar_menu_visible: 0
    },
    checkSidebarImage: function() {
        $sidebar = $('.sidebar');
        image_src = $sidebar.data('image');
        if (image_src !== undefined) {
            sidebar_container = '<div class="sidebar-background" style="background-image: url(' + image_src + ') "/>'
            $sidebar.append(sidebar_container);
        } else if (mobile_menu_initialized == true) {
            $sidebar_wrapper.find('.navbar-form').remove();
            $sidebar_wrapper.find('.nav-mobile-menu').remove();
            mobile_menu_initialized = false;
        }
    },
    initRightMenu: function() {
        $sidebar_wrapper = $('.sidebar-wrapper');
        if (!mobile_menu_initialized) {
            $navbar = $('nav').find('.navbar-collapse').first().clone(true);
            nav_content = '';
            mobile_menu_content = '';
            $navbar.children('ul').each(function() {
                content_buff = $(this).html();
                nav_content = nav_content + content_buff;
            });
            nav_content = '<ul class="nav nav-mobile-menu">' + nav_content + '</ul>';
            $navbar_form = $('nav').find('.navbar-form').clone(true);
            $sidebar_nav = $sidebar_wrapper.find(' > .nav');
            $nav_content = $(nav_content);
            $nav_content.insertBefore($sidebar_nav);
            $navbar_form.insertBefore($nav_content);
            $(".sidebar-wrapper .dropdown .dropdown-menu > li > a").click(function(event) {
                event.stopPropagation();
            });
            mobile_menu_initialized = true;
        } else {
            console.log('window with:' + $(window).width());
            if ($(window).width() > 991) {
                $sidebar_wrapper.find('.navbar-form').remove();
                $sidebar_wrapper.find('.nav-mobile-menu').remove();
                mobile_menu_initialized = false;
            }
        }
        if (!toggle_initialized) {
            $toggle = $('.navbar-toggler');
            $toggle.click(function() {
                if (mobile_menu_visible == 1) {
                    $('html').removeClass('nav-open');
                    $('.close-layer').remove();
                    setTimeout(function() {
                        $toggle.removeClass('toggled');
                    }, 400);
                    mobile_menu_visible = 0;
                } else {
                    setTimeout(function() {
                        $toggle.addClass('toggled');
                    }, 430);
                    main_panel_height = $('.main-panel')[0].scrollHeight;
                    $layer = $('<div class="close-layer"></div>');
                    $layer.css('height', main_panel_height + 'px');
                    $layer.appendTo(".main-panel");
                    setTimeout(function() {
                        $layer.addClass('visible');
                    }, 100);
                    $layer.click(function() {
                        $('html').removeClass('nav-open');
                        mobile_menu_visible = 0;
                        $layer.removeClass('visible');
                        setTimeout(function() {
                            $layer.remove();
                            $toggle.removeClass('toggled');
                        }, 400);
                    });
                    $('html').addClass('nav-open');
                    mobile_menu_visible = 1;
                }
            });
            toggle_initialized = true;
        }
    }
}

function debounce(func, wait, immediate) {
    var timeout;
    return function() {
        var context = this,
            args = arguments;
        clearTimeout(timeout);
        timeout = setTimeout(function() {
            timeout = null;
            if (!immediate) func.apply(context, args);
        }, wait);
        if (immediate && !timeout) func.apply(context, args);
    };
};
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-46172202-1']);
_gaq.push(['_trackPageview']);
(function() {
    var ga = document.createElement('script');
    ga.type = 'text/javascript';
    ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(ga, s);
})();