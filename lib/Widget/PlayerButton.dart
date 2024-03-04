import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {

  const PlayerButtons({
    super.key,
    required this.audioPlayer,
    required this.changeBackground 
  });

  final AudioPlayer audioPlayer;
  final Function changeBackground;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: audioPlayer.sequenceStateStream, 
          builder: (context,index){
            return IconButton(
              onPressed: audioPlayer.hasPrevious ? () => {
                changeBackground(),
                audioPlayer.seekToPrevious()
              }: null, 
              iconSize: 45,
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
              );
          },
          ),
        StreamBuilder(
          stream: audioPlayer.playerStateStream, 
          builder: (contex, snapshot){
            if(snapshot.hasData){
              final playerState = snapshot.data;
              final processingState = (playerState! as PlayerState).processingState;
    
              if  (processingState == ProcessingState.loading || 
                    processingState == ProcessingState.buffering){
                      return Container(
                        width: 64.0,
                        height: 64.0,
                        margin: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(!audioPlayer.playing){
                      return IconButton(
                        onPressed: audioPlayer.play, 
                        iconSize: 75,
                        icon: Icon(Icons.play_circle, 
                      color: Colors.white,),
                      );
                    }
                    else if(ProcessingState != ProcessingState.completed){
                      return IconButton(
                        icon: Icon(
                          Icons.pause_circle, 
                          color: Colors.white,
                      ), 
                        iconSize: 75,
                        onPressed: audioPlayer.pause,
                      );
                    }
                    else{
                      return IconButton(
                        icon: Icon(
                          Icons.replay_circle_filled_outlined, 
                          color: Colors.white,
                      ), 
                        iconSize: 75,
                        onPressed: () => audioPlayer.seek(
                          Duration.zero, 
                          index: audioPlayer.effectiveIndices!.first
                          ),
                      );
                    }
            }
            else{
                  return CircularProgressIndicator();
                }
          }
        ),
        StreamBuilder(
          stream: audioPlayer.sequenceStateStream, 
          builder: (context,index){
            return IconButton(
              onPressed: audioPlayer.hasNext ? () => {
                changeBackground(),
                audioPlayer.seekToNext()
              }: null, 
              iconSize: 45,
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
              );
          },
          ),
      ],
    );
  }
}