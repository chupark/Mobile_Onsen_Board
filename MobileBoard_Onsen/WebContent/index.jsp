<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" charset="UTF-8"/>
  <link rel="stylesheet" href="/MobileBoard_Onsen/resource/OnsenUI-dist-2.9.2/css/onsenui.css">
  <link rel="stylesheet" href="/MobileBoard_Onsen/resource/OnsenUI-dist-2.9.2/css/onsen-css-components.min.css">
  <script src="/MobileBoard_Onsen/resource/OnsenUI-dist-2.9.2/js/onsenui.min.js"></script>
  <script src="/MobileBoard_Onsen/resource/style/jquery-1.11.1.min.js"></script> 
</head>
<ons-navigator id="appNavigator" swipeable swipe-target-width="80px">
  <ons-page>
    <ons-splitter id="appSplitter">
      <ons-splitter-side id="sidemenu" page="sidemenu.html" swipeable side="right" collapse="" width="260px"></ons-splitter-side>
      <ons-splitter-content page="tabbar.html"></ons-splitter-content>
    </ons-splitter>
  </ons-page>
</ons-navigator>

<template id="tabbar.html">
  <ons-page id="tabbar-page">
    <ons-toolbar>
      <div class="center">Home</div>
      <div class="right">
        <ons-toolbar-button onclick="fn.toggleMenu()">
          <ons-icon icon="ion-navicon, material:md-menu"></ons-icon>
        </ons-toolbar-button>
      </div>
    </ons-toolbar>
    <ons-tabbar swipeable id="appTabbar" position="auto">
      <ons-tab label="Home" icon="ion-home" page="home.html" active></ons-tab>
      <ons-tab label="Forms" icon="ion-edit" page="forms.html"></ons-tab>
      <ons-tab label="Animations" icon="ion-film-marker" page="animations.html"></ons-tab>
    </ons-tabbar>

    <script>
      ons.getScriptPage().addEventListener('prechange', function(event) {
        if (event.target.matches('#appTabbar')) {
          event.currentTarget.querySelector('ons-toolbar .center').innerHTML = event.tabItem.getAttribute('label');
        }
      });
    </script>
  </ons-page>
</template>

<template id="sidemenu.html">
  <ons-page>
    <div class="profile-pic">
      <img src="https://monaca.io/img/logos/download_image_onsenui_01.png">
    </div>

    <ons-list-title>Access</ons-list-title>
    <ons-list>
      <ons-list-item onclick="fn.loadView(0)">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-home, material:md-home"></ons-icon>
        </div>
        <div class="center">
          Home
        </div>
        <div class="right">
          <ons-icon icon="fa-link"></ons-icon>
        </div>
      </ons-list-item>
      <ons-list-item onclick="fn.loadView(1)">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-edit, material:md-edit"></ons-icon>
        </div>
        <div class="center">
          Forms
        </div>
        <div class="right">
          <ons-icon icon="fa-link"></ons-icon>
        </div>
      </ons-list-item>
      <ons-list-item onclick="fn.loadView(2)">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-film-marker, material: md-movie-alt"></ons-icon>
        </div>
        <div class="center">
          Animations
        </div>
        <div class="right">
          <ons-icon icon="fa-link"></ons-icon>
        </div>
      </ons-list-item>
    </ons-list>

    <ons-list-title style="margin-top: 10px">Links</ons-list-title>
    <ons-list>
      <ons-list-item onclick="fn.loadLink('https://onsen.io/v2/docs/guide/js/')">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-document-text"></ons-icon>
        </div>
        <div class="center">
          Docs
        </div>
        <div class="right">
          <ons-icon icon="fa-external-link"></ons-icon>
        </div>
      </ons-list-item>
      <ons-list-item onclick="fn.loadLink('https://github.com/OnsenUI/OnsenUI')">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-social-github"></ons-icon>
        </div>
        <div class="center">
          GitHub
        </div>
        <div class="right">
          <ons-icon icon="fa-external-link"></ons-icon>
        </div>
      </ons-list-item>
      <ons-list-item onclick="fn.loadLink('https://community.onsen.io/')">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-chatboxes"></ons-icon>
        </div>
        <div class="center">
          Forum
        </div>
        <div class="right">
          <ons-icon icon="fa-external-link"></ons-icon>
        </div>
      </ons-list-item>
      <ons-list-item onclick="fn.loadLink('https://twitter.com/Onsen_UI')">
        <div class="left">
          <ons-icon fixed-width class="list-item__icon" icon="ion-social-twitter"></ons-icon>
        </div>
        <div class="center">
          Twitter
        </div>
        <div class="right">
          <ons-icon icon="fa-external-link"></ons-icon>
        </div>
      </ons-list-item>
    </ons-list>

    <script>
      ons.getScriptPage().onInit = function() {
        // Set ons-splitter-side animation
        this.parentElement.setAttribute('animation', ons.platform.isAndroid() ? 'overlay' : 'reveal');
      };
    </script>

    <style>
      .profile-pic {
        width: 200px;
        background-color: #fff;
        margin: 20px auto 10px;
        border: 1px solid #999;
        border-radius: 4px;
      }

      .profile-pic > img {
        display: block;
        max-width: 100%;
      }

      ons-list-item {
        color: #444;
      }
    </style>
  </ons-page>
</template>

<template id="home.html">
  <ons-page>   
    <%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rset = null;
	String sql = "";
    
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
		stmt = conn.createStatement();
		/*
		sql = "SELECT * FROM("+
		   		"SELECT A.NUM, (SELECT COUNT(*) FROM LITTLE_RE B WHERE B.NUM=A.NUM) AS REPLE,"+ 
	    	   	"ROW_NUMBER() OVER(ORDER BY NUM DESC) zNUM,"+ 
	    	   	"NAME,"+ 
	    	   	"TITLE,"+
      			"TO_CHAR(CONTENT) AS CONTENT,"+
	    	   	"READ_COUNT,"+ 
	    	   	"TO_char(WRITE_DATE,'yyyy-mm-dd') AS WRITE_DATE"+
	    " FROM TB_BOARD A"+
	    ")X WHERE X.zNUM BETWEEN 1 and 10";
		*/
		sql = "SELECT ROWNUM, TITLE, AA FROM (SELECT TITLE, CONTENT AS AA FROM D_BOARD ORDER BY NUM DESC) WHERE ROWNUM <= 10";
		rset = stmt.executeQuery(sql);
		
		while(rset.next()){
			//String aa = rset.getString(6);
		%>							<!-- json 형태로 전송한다... 내용은? 쭉 아래에보면 파라미터 추가 가능함 -->
	    <ons-card onclick="fn.pushPage({'id': 'pullHook.html', 
		    						 'title': '<%=rset.getString(2)%>', 
		    						 'content': '<%=rset.getString(3)%>',
		    						 'blab' : 'aa'
			    					})">
	      <div class="title"><%=rset.getString(2)%></div>
	      <div class="content">
	      </div>
	    </ons-card>
		<%}
		
		if (conn != null){conn.close();}
		if (stmt != null){stmt.close();}
		if (rset != null){rset.close();}
		
	}catch (Exception e){
		out.println(e);
	} finally {
		if (conn != null){conn.close();}
		if (stmt != null){stmt.close();}
		if (rset != null){rset.close();}
	}
    %>
    <style>
      .intro {
        text-align: center;
        padding: 0 20px;
        margin-top: 40px;
      }

      ons-card {
        cursor: pointer;
        color: #333;
      }

      .card__title,
      .card--material__title {
        font-size: 20px;
      }
    </style>
  </ons-page>
</template>

<template id="pullHook.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>
    <ons-pull-hook id="pull-hook" threshold-height="120px">
      <ons-icon id="pull-hook-icon" size="22px" class="pull-hook-content" icon="fa-arrow-down"></ons-icon>
    </ons-pull-hook>
    <ons-card>
    	<div class="content"></div>
    </ons-card>
	<script>
	
	</script>
    <ons-list id="kitten-list">
      <ons-list-header>Pull to refresh</ons-list-header>
    </ons-list>
		<script>
		      ons.getScriptPage().onInit = function () {
		        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
		        this.querySelector('ons-card div.content').textContent = this.data.content;
		      }
		</script>
    <style>
      .pull-hook-content {
        color: #666;
        transition: transform .25s ease-in-out;
      }
    </style>
  </ons-page>
</template>

<template id="pullHook2.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>

    <ons-pull-hook id="pull-hook" threshold-height="120px">
      <ons-icon id="pull-hook-icon" size="22px" class="pull-hook-content" icon="fa-arrow-down"></ons-icon>
    </ons-pull-hook>

    <ons-list id="kitten-list">
      <ons-list-header>Pull to refresh</ons-list-header>
    </ons-list>
		
    <style>
      .pull-hook-content {
        color: #666;
        transition: transform .25s ease-in-out;
      }
    </style>
  </ons-page>
</template>

<template id="forms.html">
  <ons-page id="forms-page">
    <ons-card>
    	<div class="content">
<script type="text/javascript">
			$(function() {
				$('#goSubmit').on('click', function() {
					var params = $('#insertForm').serialize();
					$.ajax({
						url : 'insertdata.jsp',
						data : params,
						success : function(data) {
							var succ = data.trim();
							if(succ == "Y") {
								location.href = "index.jsp";
							} else {
								alert('실패 : id가 일치하지 않음');
							}
						}
					});
				});
			});
			</script>
			<form id="insertForm" name="insertForm" method="post">		 	
	    		<table border=1 width=100% height=88%>
	    			<tr>
	    				<td width=20% height=10%>
	    					제목
	    				</td>
	    				<td width=80% >
				    		<input type="text" id="title" name="title" style="width:100%;height:100%"/>
				    	</td>
				    </tr>
				    <tr>
				    	<td height=90%>
				    		내용
				    	</td>
				    	<td >
				    		<textarea id="content" name="content"  
				    		style="width:100%;height:100%;resize:none"  id=content></textarea>
				    	</td>
				    </tr>
				    <tr>
				    	<td width=20%></td>
				    	<td width=80% align=right>
				    		<input type="button" id="goSubmit" value="게시" />
				    	</td>
				    </tr>
	    		</table>
	    	</form>
    	</div>
    </ons-card>

    <style>
      .right-icon {
        margin-left: 10px;
      }

      .right-label {
        color: #666;
      }
    </style>
  </ons-page>
</template>

<template id="animations.html">
  <ons-page>
    <ons-list>
      <ons-list-header>Transitions</ons-list-header>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'none'}, 'none')">
        none
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'default'}, 'default')">
        default
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'slide-ios'}, 'slide-ios')">
        slide-ios
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'slide-md'}, 'slide-md')">
        slide-md
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'lift-ios'}, 'lift-ios')">
        lift-ios
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'lift-md'}, 'lift-md')">
        lift-md
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'fade-ios'}, 'fade-ios')">
        fade-ios
      </ons-list-item>
      <ons-list-item modifier="chevron" onclick="fn.pushPage({'id': 'transition.html', 'title': 'fade-md'}, 'fade-md')">
        fade-md
      </ons-list-item>
    </ons-list>
  </ons-page>
</template>

<template id="dialogs.html">
  <ons-page id="dialogs-page">
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
      <div class="right">
        <ons-toolbar-button id="info-button" onclick="fn.showDialog('popover-dialog')"></ons-toolbar-button>
      </div>
    </ons-toolbar>

    <ons-list-title>Notifications</ons-list-title>
    <ons-list modifier="inset">
      <ons-list-item tappable modifier="longdivider" onclick="ons.notification.alert('Hello, world!')">
        <div class="center">
          Alert
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="ons.notification.confirm('Are you ready?')">
        <div class="center">
          Simple Confirmation
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="ons.notification.prompt('What is your name?')">
        <div class="center">
          Prompt
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="ons.notification.toast('Hi there!', { buttonLabel: 'Dismiss', timeout: 1500 })">
        <div class="center">
          Toast
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="ons.openActionSheet({ buttons: ['Label 1', 'Label 2', 'Label 3', 'Cancel'], destructive: 2, cancelable: true })">
        <div class="center">
          Action/Bottom Sheet
        </div>
      </ons-list-item>
    </ons-list>

    <ons-list-title>Components</ons-list-title>
    <ons-list modifier="inset">
      <ons-list-item tappable modifier="longdivider" onclick="fn.showDialog('lorem-dialog')">
        <div class="center">
          Simple Dialog
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="fn.showDialog('watHmmSure-dialog')">
        <div class="center">
          Alert Dialog
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="fn.showDialog('toast-dialog')">
        <div class="center">
          Toast (top)
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="fn.showDialog('modal-dialog')">
        <div class="center">
          Modal
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="fn.showDialog('popover-dialog')">
        <div class="center">
          Popover - MD Menu
        </div>
      </ons-list-item>
      <ons-list-item tappable modifier="longdivider" onclick="fn.showDialog('action-sheet-dialog')">
        <div class="center">
          Action/Bottom Sheet
        </div>
      </ons-list-item>
    </ons-list>

    <!-- Components -->
    <ons-dialog id="lorem-dialog" cancelable>
      <!-- Optional page. This could contain a Navigator as well. -->
      <ons-page>
        <ons-toolbar>
          <div class="center">Simple Dialog</div>
        </ons-toolbar>
        <p style="text-align: center">Lorem ipsum dolor</p>
        <p style="text-align: center">
          <ons-button modifier="light" onclick="fn.hideDialog('lorem-dialog')">Close</ons-button>
        </p>
      </ons-page>
    </ons-dialog>

    <ons-alert-dialog id="watHmmSure-dialog" cancelable>
      <div class="alert-dialog-title">Hey!!</div>
      <div class="alert-dialog-content">
        Lorem ipsum
        <ons-icon icon="fa-commenting-o"></ons-icon>
      </div>
      <div class="alert-dialog-footer">
        <button class="alert-dialog-button" onclick="fn.hideDialog('watHmmSure-dialog')">Wat</button>
        <button class="alert-dialog-button" onclick="fn.hideDialog('watHmmSure-dialog')">Hmm</button>
        <button class="alert-dialog-button" onclick="fn.hideDialog('watHmmSure-dialog')">Sure</button>
      </div>
    </ons-alert-dialog>

    <ons-toast id="toast-dialog" animation="fall">Supercalifragilisticexpialidocious<button onclick="fn.hideDialog('toast-dialog')">No way</button></ons-toast>

    <ons-modal id="modal-dialog" onclick="fn.hideDialog('modal-dialog')">
      <p style="text-align: center">
        Loading
        <ons-icon icon="fa-spinner" spin></ons-icon>
        <br><br> Click or wait
      </p>
    </ons-modal>

    <ons-popover id="popover-dialog" cancelable direction="down" cover-target target="#info-button">
      <ons-list id="popover-list">
        <ons-list-item class="more-options" tappable onclick="fn.hideDialog('popover-dialog')">
          <div class="center">Call history</div>
        </ons-list-item>
        <ons-list-item class="more-options" tappable onclick="fn.hideDialog('popover-dialog')">
          <div class="center">Import/export</div>
        </ons-list-item>
        <ons-list-item class="more-options" tappable onclick="fn.hideDialog('popover-dialog')">
          <div class="center">New contact</div>
        </ons-list-item>
        <ons-list-item class="more-options" tappable onclick="fn.hideDialog('popover-dialog')">
          <div class="center">Settings</div>
        </ons-list-item>
      </ons-list>
    </ons-popover>

    <ons-action-sheet id="action-sheet-dialog" cancelable>
      <ons-action-sheet-button onclick="fn.hideDialog('action-sheet-dialog')" icon="md-square-o">Action 1</ons-action-sheet-button>
      <ons-action-sheet-button onclick="fn.hideDialog('action-sheet-dialog')" icon="md-square-o">Action 2</ons-action-sheet-button>
      <ons-action-sheet-button onclick="fn.hideDialog('action-sheet-dialog')" modifier="destructive" icon="md-square-o">Action 3</ons-action-sheet-button>
      <ons-action-sheet-button onclick="fn.hideDialog('action-sheet-dialog')" icon="md-square-o">Cancel</ons-action-sheet-button>
    </ons-action-sheet>

    <script>
      ons.getScriptPage().onInit = function () {
        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
        var toolbarButton = ons.platform.isAndroid() ? ons.createElement(`<ons-icon icon="md-more-vert"></ons-icon>`) : ons.createElement(`<span>More</span>`);
        var infoButton = document.getElementById('info-button');
        infoButton.appendChild(toolbarButton);
        var toastDialog = document.getElementById('toast-dialog');
        toastDialog.parentNode.removeChild(toastDialog);
        document.getElementById('dialogs-page').appendChild(toastDialog);
        var timeoutID = 0;
        window.fn.showDialog = function (id) {
          var elem = document.getElementById(id);
          if (id === 'popover-dialog') {
            elem.show(infoButton);
          } else {
            elem.show();
            if (id === 'modal-dialog') {
              clearTimeout(timeoutID);
              timeoutID = setTimeout(function() { fn.hideDialog(id) }, 2000);
            }
          }
        };
        window.fn.hideDialog = function (id) {
          document.getElementById(id).hide();
        };
        const moreOptions = document.querySelectorAll('.more-options');
        if (!ons.platform.isAndroid()) {
          document.getElementById('watHmmSure-dialog').setAttribute('modifier', 'rowfooter');
          for (option of moreOptions) {
            option.hasAttribute('modifier') ?
              option.setAttribute('modifier', option.getAttribute('modifier') + ' longdivider') :
              option.setAttribute('modifier', 'longdivider');
          }
        } else {
          for (option of moreOptions) {
            option.hasAttribute('modifier') ?
              option.setAttribute('modifier', option.getAttribute('modifier') + ' nodivider') :
              option.setAttribute('modifier', 'nodivider');
          }
        }
      };
      document.getElementById('appNavigator').topPage.onDestroy = function () {
        var toastDialog = document.getElementById('toast-dialog');
        toastDialog.parentNode.removeChild(toastDialog);
        document.querySelector('#dialogs-page .page__content').appendChild(toastDialog);
      }
    </script>

    <style>
      #lorem-dialog .dialog-container {
        height: 200px;
      }

      ons-list-title {
        margin-top: 20px;
      }
    </style>
  </ons-page>
</template>

<template id="buttons.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>

    <section style="margin: 16px">
      <ons-button class="button-margin">Normal</ons-button>
      <ons-button modifier="quiet" class="button-margin">Quiet</ons-button>
      <ons-button modifier="outline" class="button-margin">Outline</ons-button>
      <ons-button modifier="cta" class="button-margin">Call to action</ons-button>
      <ons-button modifier="light" class="button-margin">Light</ons-button>
      <ons-button modifier="large" class="button-margin">Large</ons-button>
    </section>

    <section style="margin: 16px">
      <ons-button class="button-margin" disabled>Normal</ons-button>
      <ons-button modifier="quiet" class="button-margin" disabled>Quiet</ons-button>
      <ons-button modifier="outline" class="button-margin" disabled>Outline</ons-button>
      <ons-button modifier="cta" class="button-margin" disabled>Call to action</ons-button>
      <ons-button modifier="light" class="button-margin" disabled>Light</ons-button>
      <ons-button modifier="large" class="button-margin" disabled>Large</ons-button>
    </section>

    <ons-fab position="top right">
      <ons-icon icon="md-face"></ons-icon>
    </ons-fab>

    <ons-fab position="bottom left" disabled>
      <ons-icon icon="md-car"></ons-icon>
    </ons-fab>

    <ons-speed-dial position="bottom right" direction="up" :open.sync="spdOpen">
      <ons-fab>
        <ons-icon icon="md-share"></ons-icon>
      </ons-fab>
      <ons-speed-dial-item onclick="ons.notification.confirm(`Share on Twitter?`)">
        <ons-icon icon="md-twitter"></ons-icon>
      </ons-speed-dial-item>
      <ons-speed-dial-item onclick="ons.notification.confirm(`Share on Facebook?`)">
        <ons-icon icon="md-facebook"></ons-icon>
      </ons-speed-dial-item>
      <ons-speed-dial-item onclick="ons.notification.confirm(`Share on Google+`)">
        <ons-icon icon="md-google-plus"></ons-icon>
      </ons-speed-dial-item>
    </ons-speed-dial>

    <script>
      ons.getScriptPage().onInit = function () {
        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
      }
    </script>

    <style>
      .button-margin {
        margin: 6px 0;
      }
    </style>
  </ons-page>
</template>

<template id="carousel.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>

    <ons-carousel id="carousel" fullscreen swipeable auto-scroll overscrollable initial-index="0">
      <ons-carousel-item class="carousel-item" style="background-color: gray">
        <div class="color-tag">Gray</div>
      </ons-carousel-item>
      <ons-carousel-item class="carousel-item" style="background-color: #085078">
        <div class="color-tag">Blue</div>
      </ons-carousel-item>
      <ons-carousel-item class="carousel-item" style="background-color: #373B44">
        <div class="color-tag">Dark</div>
      </ons-carousel-item>
      <ons-carousel-item class="carousel-item" style="background-color: #D38312">
        <div class="color-tag">Orange</div>
      </ons-carousel-item>
    </ons-carousel>

    <div class="dots">
      <span id="dot0" class="dot" onclick="fn.swipe(this)">
        &#9679;
      </span>
      <span id="dot1" class="dot" onclick="fn.swipe(this)">
        &#9675;
      </span>
      <span id="dot2" class="dot" onclick="fn.swipe(this)">
        &#9675;
      </span>
      <span id="dot3" class="dot" onclick="fn.swipe(this)">
        &#9675;
      </span>
    </div>

    <script>
      ons.getScriptPage().onInit = function () {
        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
        const carousel = document.getElementById('carousel');
        carousel.addEventListener('postchange', function () {
          var index = carousel.getActiveIndex();
          const dots = document.querySelectorAll('.dot');
          for (dot of dots) {
            dot.innerHTML = dot.id === 'dot' + index ? '&#9679;' : '&#9675;';
          }
        });
        window.fn.swipe = function (target) {
          carousel.setActiveIndex(Number(target.id.slice(-1)));
        }
      }
    </script>

    <style>
      .carousel-item {
        display: flex;
        justify-content: space-around;
        align-items: center;
      }

      .color-tag {
        color: #fff;
        font-size: 48px;
        font-weight: bold;
        text-transform: uppercase;
      }

      .dots {
        text-align: center;
        font-size: 30px;
        color: #fff;
        position: absolute;
        bottom: 40px;
        left: 0;
        right: 0;
      }

      .dots > span {
        cursor: pointer;
      }
    </style>
  </ons-page>
</template>

<template id="loadMore.html">
  <!-- Load more items on scroll bottom -->
  <ons-page id="load-more-page" on-infinite-scroll="fn.loadMore">
    <p class="intro">
      Useful for loading more items when the scroll reaches the bottom of the page, typically after an asynchronous API call.<br><br>
    </p>

    <ons-list id="list-node"></ons-list>

    <div class="after-list">
      <ons-icon icon="fa-spinner" size="26px" spin></ons-icon>
    </div>

    <script>
      ons.getScriptPage().onInit = function () {
        var listNode = document.getElementById('list-node');
        var createListItem = function (i) {
          return ons.createElement(`<ons-list-item>Item #${i}</ons-list-item>`);
        }
        for (var i = 0; i < 30; i++) {
          listNode.appendChild(createListItem(i));
        }
        window.fn.loadMore = function (done) {
          setTimeout(function() {
            const listLength = listNode.children.length;
            for (var i = 0; i < 10; i++) {
              listNode.appendChild(createListItem(listLength + i));
            }
            done();
          }, 600)
        }
      }
    </script>

    <style>
      .after-list {
        margin: 20px;
        text-align: center;
      }
    </style>
  </ons-page>
</template>

<template id="lazyRepeat.html">
  <!-- Lazy load thousands of items -->
  <ons-page id="lazy-repeat-page">
    <p class="intro">
      Automatically unloads items that are not visible and loads new ones. Useful when the list contains thousands of items.<br><br>
    </p>

    <ons-list>
      <ons-lazy-repeat id="infinite-list"></ons-lazy-repeat>
    </ons-list>

    <script>
      ons.getScriptPage().onInit = function () {
        var infiniteList = document.getElementById('infinite-list');

        infiniteList.delegate = {
          createItemContent: function (i) {
            return ons.createElement(`<ons-list-item>Item #${i}</ons-list-item>`);
          },
          countItems: function () {
            return 3000;
          }
        };

        infiniteList.refresh();
      }
    </script>

    <style>
      .intro {
        text-align: center;
        padding: 0 20px;
        margin-top: 40px;
      }
    </style>
  </ons-page>
</template>

<template id="infiniteScroll.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>

    <ons-tabbar position="auto">
      <ons-tab label="Load More" page="loadMore.html"></ons-tab>
      <ons-tab label="Lazy Repeat" page="lazyRepeat.html" active></ons-tab>
    </ons-tabbar>

    <script>
      ons.getScriptPage().onInit = function () {
        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
      }
    </script>
  </ons-page>
</template>

<template id="progress.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Home</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>

    <ons-progress-bar id="progress-value" class="progressStyle" value="0"></ons-progress-bar>

    <section style="margin: 40px 16px">
      <p id="progress-status">
        Progress: 0%
      </p>

      <p>
        <ons-progress-bar class="progressStyle" value="20"></ons-progress-bar>
      </p>

      <p>
        <ons-progress-bar class="progressStyle" value="40" secondary-value="80"></ons-progress-bar>
      </p>

      <p>
        <ons-progress-bar class="progressStyle" indeterminate></ons-progress-bar>
      </p>

      <div style="text-align: center; margin: 40px; color: #666">
        <p>
          <ons-progress-circular class="progressStyle" value="20"></ons-progress-circular>
          <ons-progress-circular class="progressStyle" value="40" secondary-value="80"></ons-progress-circular>
          <ons-progress-circular class="progressStyle" indeterminate></ons-progress-circular>
        </p>

        <p>
          <ons-icon icon="ion-load-a" spin size="30px"></ons-icon>
          <ons-icon icon="ion-load-b" spin size="30px"></ons-icon>
          <ons-icon icon="ion-load-c" spin size="30px"></ons-icon>
          <ons-icon icon="ion-load-d" spin size="30px"></ons-icon>
        </p>

        <p>
          <ons-icon icon="fa-spinner" spin size="26px"></ons-icon>
          <ons-icon icon="circle-o-notch" spin size="26px"></ons-icon>
        </p>

        <p>
          <ons-icon icon="md-spinner" spin size="30px"></ons-icon>
        </p>
      </div>

      <p>
        <ons-button modifier="large">
          <ons-icon icon="ion-load-c" spin size="26px"></ons-icon>
        </ons-button>
        <br><br>
        <ons-button modifier="large" disabled>
          <ons-icon icon="ion-load-c" spin size="26px"></ons-icon>
        </ons-button>
      </p>
    </section>

    <script>
      ons.getScriptPage().onInit = function () {
        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
        if (!ons.platform.isAndroid()) {
          const progressStyle = document.querySelectorAll('.progressStyle');
          for (progress of progressStyle) {
            progress.hasAttribute('modifier') ?
              progress.setAttribute('modifier', progress.getAttribute('modifier') + ' ios') :
              progress.setAttribute('modifier', 'ios');
          }
        }
        var progressStatus = document.getElementById('progress-status');
        var progressValue = document.getElementById('progress-value');
        var intervalID = 0;
        intervalID = setInterval(function() {
          if (progressValue.value === 100) {
            clearInterval(intervalID);
            return;
          }
          progressValue.value++;
          progressStatus.innerHTML = `Progress: ${progressValue.value}%`;
        }, 40);
      }
    </script>

    <style>
      /* 'ios' modifier */

      .progress-bar--ios__primary,
      .progress-bar--ios.progress-bar--indeterminate::before,
      .progress-bar--ios.progress-bar--indeterminate::after {
        background-color: #4282cc
      }

      .progress-bar--ios__secondary {
        background-color: #87b6eb;
      }

      .progress-circular--ios__primary {
        stroke: #4282cc
      }

      .progress-circular--ios__secondary {
        stroke: #87b6eb;
      }
    </style>
  </ons-page>
</template>

<template id="transition.html">
  <ons-page>
    <ons-toolbar>
      <div class="left">
        <ons-back-button>Animations</ons-back-button>
      </div>
      <div class="center"></div>
    </ons-toolbar>
    <p style="text-align: center">
      Use the VOnsBackButton
    </p>
    <script>
      ons.getScriptPage().onInit = function () {
        this.querySelector('ons-toolbar div.center').textContent = this.data.title;
      }
    </script>
  </ons-page>
</template>

<style>
  ons-splitter-side[animation=overlay] {
    border-left: 1px solid #bbb;
  }
</style>
<script>
window.fn = {};

window.fn.toggleMenu = function () {
  document.getElementById('appSplitter').right.toggle();
};

window.fn.loadView = function (index) {
  document.getElementById('appTabbar').setActiveTab(index);
  document.getElementById('sidemenu').close();
};

window.fn.loadLink = function (url) {
  window.open(url, '_blank');
};

window.fn.pushPage = function (page, anim) {
  if (anim) {
    document.getElementById('appNavigator').pushPage(page.id, { data: { title: page.title, content: page.content}, animation: anim });
  } else {
    document.getElementById('appNavigator').pushPage(page.id, { data: { title: page.title, content: page.content } });
  }
};
</script>
</html>