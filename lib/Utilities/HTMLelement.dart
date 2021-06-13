import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;

Container HTMLElement(String html,String viewID,double height,double width){
  IFrameElement someRandomHtmlElement = IFrameElement();
  String _src = "data:text/html;charset=utf-8," + Uri.encodeComponent(html);
  BodyElement bodyElement = BodyElement()..setInnerHtml(_src);
  // divElement.
  someRandomHtmlElement.src =_src;
  someRandomHtmlElement.height = height.toString();
  someRandomHtmlElement.width = width.toString();
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
      viewID,(int viewId)=> bodyElement
  );
  return    Container(
    height:height,
    width:width,
    child: HtmlElementView(
      key:UniqueKey(),
      viewType: viewID,
    ),
  );
}
// class videoElement extends StatefulWidget {
//   String url;
//   String viewID;
//   double height;
//   double width;
//   videoElement(this.url,this.viewID,this.height,this.width);
//   @override
//   _videoElementState createState() => _videoElementState(url,viewID, height, width);
// }
//
// class _videoElementState extends State<videoElement> {
//   String url;
//   String viewID;
//   double height;
//   double width;
//   String source = "";
//   _videoElementState(this.url,this.viewID,this.height,this.width);
//   ChewieController chewieController;
//   VideoPlayerController videoPlayerController;
//   IFrameElement iFrameElement = IFrameElement();
//   @override
//   void initState(){
//     super.initState();
//     if (url.startsWith('www.')){
//       List<String> codeList = url.split("/");
//       String code = codeList[codeList.length-1];
//       source = "https://player.twitch.tv/?parent=xspectre-9a3b3.web.app&video=$code";
//       iFrameElement.src =source;
//       iFrameElement.height = height.toString();
//       iFrameElement.width = width.toString();
//       ui.platformViewRegistry.registerViewFactory(
//       viewID,(int viewId)=> iFrameElement
//   );
//     }
//     else {
//       source = "https://www.youtube.com/watch?v=$url";
//       videoPlayerController = VideoPlayerController.network(source);
//       print(videoPlayerController.value.size.width.toString());
//       print(videoPlayerController.value.size.height.toString());
//       chewieController = ChewieController(
//           videoPlayerController: videoPlayerController,
//           allowFullScreen: true,
//           autoInitialize: true,
//           autoPlay: false,
//           aspectRatio: 16/9,
//           showControlsOnInitialize: true,
//           showControls: true
//       );
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     if (source.contains('youtube')) {
//       return Container(
//
//         child: Chewie(
//           controller: chewieController,
//         ),
//       );
//     }
//   else{
//       return Container(
//         height:height,
//         width:width,
//         child: HtmlElementView(
//           key:UniqueKey(),
//           viewType: viewID,
//         ),
//       );
//     }
//
//   }
// }

Container videoElement(String url,String viewID,double height,double width){
  IFrameElement someRandomHtmlElement = IFrameElement();
  url = url;
  // String src1 = '''
  //        <style>
  //        html,
  //        body {
  //            margin: 0;
  //            padding: 0;
  //            background-color: #000000;
  //            overflow: hidden;
  //            position: fixed;
  //            height: 100%;
  //            width: 100%;
  //        }
  //    </style>
  //
  // ''';
  // String src2 = '''
  // <script src="https://player.twitch.tv/js/embed/v1.js"></script>
  //      <script type="text/javascript">
  //        var options = {
  //            width: window.innerWidth,
  //            height: window.innerHeight,
  //            video: "335180634",
  //            // This should be used locally.
  //            // If deployed, i.e not local then the parent should be the url of your website.
  //            // For example if the full url of our deployed website is https://www.flutterproject.com then the parent would be
  //            // parent: ["flutterproject.com"]
  //            parent: ["localhost"]
  //        };
  //        var player = new Twitch.Player("<player div ID>", options);
  //        player.setVolume(0.5);
  //    </script>
  // ''';
  // String src3 = '''
  //    <div id="player"></div>
  //      <div id="<player div ID>"></div>
  //
  // ''';
  // String _src = '''
  //  <div id="player"></div>
  //    <script src="https://player.twitch.tv/js/embed/v1.js"></script>
  //    <div id="<player div ID>"></div>
  //    <script type="text/javascript">
  //        var options = {
  //            width: window.innerWidth,
  //            height: window.innerHeight,
  //            video: "335180634",
  //            // This should be used locally.
  //            // If deployed, i.e not local then the parent should be the url of your website.
  //            // For example if the full url of our deployed website is https://www.flutterproject.com then the parent would be
  //            // parent: ["flutterproject.com"]
  //            parent: ["localhost"]
  //        };
  //        var player = new Twitch.Player("<player div ID>", options);
  //        player.setVolume(0.5);
  //    </script>
  // ''';
  String _src = '''
  <html>
  <body>
            <style>
          iframe{
            height:100%;
            width:100%;
            }
            body {
              overflow: hidden;
            }
            iframe{
          margin-bottom:5%;
          border:1px solid red;
          text-shadow: 2px 2px 4px #000000;
          box-shadow: 6px 3px 28px 2px rgb(230, 202, 67);
          }
          </style>
          <iframe src = $url  frameborder="0" allow="accelerometer; autoplay;
  clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
  </body>
  </html>
  ''';

  someRandomHtmlElement.src =url;
  someRandomHtmlElement.height = height.toString();
  someRandomHtmlElement.width = width.toString();
  ui.platformViewRegistry.registerViewFactory(
      viewID,(int viewId)=> someRandomHtmlElement
  );

      return Container(
        child: Stack(
          children: [
            Container(
              height:height,
              width:width,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0),
                    width:10
                ),
              ),
              child: HtmlElementView(
                key:UniqueKey(),
                viewType: viewID,
              ),
            ),
          ],
        ),
      );
}