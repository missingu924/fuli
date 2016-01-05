<html lang="en">

<head>

  <meta charset="utf-8" />

  <title>jQuery UI Tabs - Content via Ajax</title>

  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

  <script src="jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>

  <script src="jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>

  <link rel="stylesheet" href="/resources/demos/style.css" />

  <script>

  $(function() {

    $( "#tabs" ).tabs({

      beforeLoad: function( event, ui ) {

        ui.jqXHR.error(function() {

          ui.panel.html(

            "Couldn't load this tab. We'll try to fix this as soon as possible. " +

            "If this wouldn't be a demo." );

        });

      }

    });

  });

  </script>

</head>

<body>

 

<div id="tabs">

  <ul>

    <li><a href="#tabs-1">Preloaded</a></li>

    <li><a href="<%=request.getContextPath()%>/TeamworkTask/Servlet?method=portal&relationshipWithUser=NEED_PROCESS%>">Tab 1</a></li>

    <li><a href="ajax/content2.html">Tab 2</a></li>

    <li><a href="ajax/content3-slow.php">Tab 3 (slow)</a></li>

    <li><a href="ajax/content4-broken.php">Tab 4 (broken)</a></li>

  </ul>

  <div id="tabs-1">

    <p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>

  </div>

</div>

 

 

</body>

</html>

