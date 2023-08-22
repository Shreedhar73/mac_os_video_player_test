//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <media_kit_video/media_kit_video_plugin_c_api.h>
#include <realm/realm_plugin.h>
#include <screen_brightness_windows/screen_brightness_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  MediaKitVideoPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MediaKitVideoPluginCApi"));
  RealmPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RealmPlugin"));
  ScreenBrightnessWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ScreenBrightnessWindowsPlugin"));
}
