if status is-interactive
    # Commands to run in interactive sessions can go here
  fish_vi_key_bindings
  zoxide init --cmd j fish | source
  zoxide init --cmd cd fish | source

  set -xg EDITOR nvim
  # useful install proo-distro within termux
  set -xg ANDROID_ART_ROOT /apex/com.android.art
  set -xg ANDROID_DATA /data
  set -xg ANDROID_I18N_ROOT /apex/com.android.i18n
  set -xg ANDROID_ROOT /system
  set -xg ANDROID_RUNTIME_ROOT /apex/com.android.runtime
  set -xg ANDROID_TZDATA_ROOT /apex/com.android.tzdata
  set -xg BOOTCLASSPATH /apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/framework-graphics.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/knoxsdk.jar:/system/framework/knoxanalyticssdk.jar:/system/framework/uibc_java.jar:/system/framework/SmpsManager.jar:/apex/com.android.i18n/javalib/core-icu4j.jar:/apex/com.android.appsearch/javalib/framework-appsearch.jar:/apex/com.android.conscrypt/javalib/conscrypt.jar:/apex/com.android.ipsec/javalib/android.net.ipsec.ike.jar:/apex/com.android.media/javalib/updatable-media.jar:/apex/com.android.mediaprovider/javalib/framework-mediaprovider.jar:/apex/com.android.os.statsd/javalib/framework-statsd.jar:/apex/com.android.permission/javalib/framework-permission.jar:/apex/com.android.permission/javalib/framework-permission-s.jar:/apex/com.android.scheduling/javalib/framework-scheduling.jar:/apex/com.android.sdkext/javalib/framework-sdkextensions.jar:/apex/com.android.tethering/javalib/framework-connectivity.jar:/apex/com.android.tethering/javalib/framework-tethering.jar:/apex/com.android.wifi/javalib/framework-wifi.jar:/apex/com.samsung.android.ipm/javalib/framework-samsung-ipm.jar:/apex/com.samsung.android.shell/javalib/framework-samsung-privilege.jar
  set -xg COLORTERM truecolor
  set -xg DEX2OATBOOTCLASSPATH /apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/framework-graphics.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/knoxsdk.jar:/system/framework/knoxanalyticssdk.jar:/system/framework/uibc_java.jar:/system/framework/SmpsManager.jar:/apex/com.android.i18n/javalib/core-icu4j.jar
  set -xg EXTERNAL_STORAGE /storage/self/primary
  [ -z "gLANG" ] && set -xq LANG C.UTF-8
  set -xg TERM xterm-256color
  set -xg TMPDIR /tmp
  set -xg PULSE_SERVER 127.0.0.1
  set -xg MOZ_FAKE_NO_SANDBOX 1
  set -xg ZK_NOTEBOOK_DIR ~/willydeliege/
  fzf_configure_bindings --git_status=\cS --directory=\cF --git_log=\cO  
end
