part of '../youtube_player_widget.dart';

enum SettingsOptions {
  setSpeed('velocidade'),
  setVolume('volume');

  const SettingsOptions(this.value);

  final String value;
}

enum MediaSpeedOption {
  x025('0.25x', 0.25),
  x050('0.5x', 0.5),
  x075('0.75x', 0.75),
  x100('1x', 1.0),
  x125('1.25x', 1.25),
  x150('1.5x', 1.5),
  x175('1.75x', 1.75),
  x200('2x', 2.0);

  const MediaSpeedOption(this.label, this.value);

  final String label;
  final double value;
}

mixin YoutubePlayerPopMenus {
  MediaSpeedOption videoSpeed = MediaSpeedOption.x100;

  ValueNotifier<int> videoVolume = ValueNotifier(100);

  Widget speedMenuButton(BuildContext context, Function setOptions) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return TextButton(
          style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColors.primaryColor)),
          child: Align(
              
              alignment: Alignment.centerLeft,
              child: Text(
                "velocidade (${videoSpeed.label})",
                textAlign: TextAlign.start,
              )),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: MediaSpeedOption.values
          .map((e) => MenuItemButton(
              onPressed: () {
                setOptions(e);
              },
              child: Text(e.label)))
          .toList(),
    );
  }

  Widget volumeMenuButton(BuildContext context, Function setOptions) {
    return MenuAnchor(
        builder: (context, controller, child) {
          return TextButton(
            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColors.primaryColor)),
            child: ListenableBuilder(
                listenable: videoVolume,
                builder: (context, child) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "volume (${(videoVolume.value).toStringAsFixed(0)})",
                        textAlign: TextAlign.start,
                      ),
                    )),
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
          );
        },
        menuChildren: [
          Container(
              width: 250,
              padding: const EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: videoVolume,
                builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Slider(
                          label: 'volume',
                          value: value * 1.0,
                          min: 0.0,
                          max: 100,
                          onChanged: (value) {
                            setOptions(value.toInt());
                          }),
                      Text('${(videoVolume.value).toInt()}', style: AppTextStyles.primaryMedium,),
                    ],
                 ),
              ))
        ].toList());
  }
}
