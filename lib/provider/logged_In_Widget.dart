//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  State<LoggedInWidget> createState() => _LoggedInWidgetState();
}

enum TtsState { playing, stopped }

class _LoggedInWidgetState extends State<LoggedInWidget> {
  //final user = FirebaseAuth.instance.currentUser!;
  late FlutterTts _flutterTts;
  String? _tts;
  TtsState _ttsState = TtsState.stopped;
  String answer = "";
  CameraController? cameraController;
  CameraImage? cameraImage;
  bool flash = false;
  bool isRecoring = false;
  double transform = 0;
  bool iscamerafront = false;
  int cameraPos = 0;

  loadmodel() async {
    Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  initCamera() {
    // cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    // OR
    cameraController = CameraController(
        CameraDescription(
          name:
              cameraPos.toString(), // 0 for back camera and 1 for front camera
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 270,
        ),
        ResolutionPreset.max);

    cameraController!.initialize().then(
      (value) {
        if (!mounted) {
          return;
        }
        setState(
          () {
            cameraController!.startImageStream(
              (image) => {
                if (true)
                  {
                    cameraImage = image,
                    if (isRecoring == true)
                      {
                        applymodelonimages(),
                      }
                    else
                      {answer = ""}
                  }
              },
            );
          },
        );
      },
    );
  }

  applymodelonimages() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map(
            (plane) {
              return plane.bytes;
            },
          ).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 3,
          threshold: 0.1,
          asynch: true);

      answer = '';

      for (var prediction in predictions!) {
        answer = prediction['label'].toString().substring(1) +
            " " +
            (prediction['confidence'] as double).toStringAsFixed(3) +
            '\n';
      }

      setState(
        () {
          answer = answer;
          _tts = answer;
          print("ioggoggggggggggggggui : " + answer);
        },
      );
    }
  }

  initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.awaitSpeakCompletion(true);

    _flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        _ttsState = TtsState.playing;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        print("Error: $message");
        _ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    //loadmodel();
    loadmodel();
    initTts();
  }

  @override
  void dispose() async {
    super.dispose();
    _flutterTts.stop();
    await Tflite.close();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 23, 31),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Stack(
              children: [
                Positioned(
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: cameraController!.value.aspectRatio,
                        child: CameraPreview(
                          cameraController!,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 29, 0, 0),
                          child: FittedBox(
                            //<-- SEE HERE
                            child: FloatingActionButton.small(
                              //<-- SEE HERE
                              backgroundColor: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                                cameraController!.setFlashMode(FlashMode.off);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 160,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                          child: Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: NetworkImage(user.photoURL!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                color: Colors.black,
                                width: 4.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Container(
                            width: 45,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(42.0),
                              color: const Color.fromARGB(121, 66, 64, 64),
                            ),
                            child: Column(
                              children: [
                                FittedBox(
                                  //<-- SEE HERE
                                  child: FloatingActionButton.small(
                                    elevation: 0.0,
                                    //<-- SEE HERE
                                    backgroundColor:
                                        const Color.fromARGB(0, 80, 71, 71),
                                    onPressed: () {
                                      setState(() {
                                        flash = !flash;
                                      });
                                      flash
                                          ? cameraController!
                                              .setFlashMode(FlashMode.torch)
                                          : cameraController!
                                              .setFlashMode(FlashMode.off);
                                    },
                                    child: Icon(
                                      flash ? Icons.flash_on : Icons.flash_off,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  //<-- SEE HERE
                                  child: FloatingActionButton.small(
                                    elevation: 0.0,
                                    //<-- SEE HERE
                                    backgroundColor:
                                        const Color.fromARGB(0, 80, 71, 71),
                                    onPressed: () async {
                                      setState(() {
                                        if (cameraPos == 0) {
                                          cameraPos = 1;
                                        } else if (cameraPos == 1) {
                                          cameraPos = 0;
                                        }
                                      });
                                      initCamera();
                                    },
                                    child: const Icon(
                                      Icons.flip_camera_ios,
                                      color: Colors.white,
                                      size: 27,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  //<-- SEE HERE
                                  child: FloatingActionButton.small(
                                    elevation: 0.0,
                                    //<-- SEE HERE
                                    backgroundColor:
                                        const Color.fromARGB(0, 80, 71, 71),
                                    onPressed: () async {},
                                    child: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 350,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              answer,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isRecoring = true;
                        });
                        speak();
                      },
                      onTapCancel: () async {
                        setState(() {
                          isRecoring = false;
                        });
                        stop();
                      },
                      child: isRecoring
                          ? const Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 90,
                            )
                          : const Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 90,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future speak() async {
    await _flutterTts.setVolume(1);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1);

    if (_tts != null) {
      if (_tts!.isNotEmpty) {
        await _flutterTts.speak(_tts!);
      }
    }
  }

  Future stop() async {
    var result = await _flutterTts.stop();
    if (result == 1) {
      setState(() {
        _ttsState = TtsState.stopped;
      });
    }
  }
}
