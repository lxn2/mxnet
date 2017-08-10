/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

var searchBox = $("#search-input-wrap");
var TITLE = ['/get_started/', '/tutorials/', '/how_to/', '/api/', '/architecture/'];
var APIsubMenu;
$("#burgerMenu").children().each(function () {
    if($(this).children().first().html() == 'API') APIsubMenu = $(this).clone()
    if($(this).children().first().html().startsWith('Versions')) VersionsubMenu = $(this).clone()
});

function navbar() {
    var leftOffset = 40;
    var plusMenuList = [];
    var plusIconLeft =$("#search-input-wrap").offset().left - leftOffset;
    var isCovered = false;
    $("#main-nav").children().each(function () {
        var rightPos;
        if($(this).is(':hidden')) {
            $(this).show();
            rightPos = $(this).offset().left + $(this).width();
            $(this).hide;
        }
        else rightPos = $(this).offset().left + $(this).width();
        
        if(isCovered) {
            plusMenuList.push($(this).clone());
            $(this).hide();
        }
        else if(rightPos > plusIconLeft) {
            isCovered = true;
            $(".plusIcon").first().show();
            plusMenuList.push($(this).clone());
            $(this).hide();
        }
        else $(this).show();
    });
    
    if(plusMenuList.length == 0) {
        $(".plusIcon").first().hide();
        return;
    }
    $("#plusMenu").empty();
    for (var i = 0; i < plusMenuList.length; ++i) {
        if(plusMenuList[i].attr('id') == 'dropdown-menu-position-anchor') {
            $("#plusMenu").append(APIsubMenu);
        }
        else if(plusMenuList[i].attr('id') == 'dropdown-menu-position-anchor-version') {
            $("#plusMenu").append(VersionsubMenu);
        }
        else {
            $("#plusMenu").append("<li></li>");
            plusMenuList[i].removeClass("main-nav-link");
            $("#plusMenu").children().last().append(plusMenuList[i]);
        }
    }
};

/*Show bottom border of current tab*/
function showTab() {
    var url = window.location.href;
    if(url.indexOf('/get_started/why_mxnet') != -1) return;
    for(var i = 0; i < TITLE.length; ++i) {
        if(url.indexOf(TITLE[i]) != -1) {
            var tab = $($('#main-nav').children().eq(i));
            if(!tab.is('a')) tab = tab.find('a').first();
            tab.css('border-bottom', '3px solid');
        }
    }
}

$(document).ready(function () {
    navbar();
    showTab();
    $(window).resize(function () {
        navbar();
    });
});
