-keep class **.zego.** { *; }
-keepclassmembers class * {
    @com.fasterxml.jackson.annotation.* *;
    @com.fasterxml.jackson.databind.annotation.* *;
    @com.fasterxml.jackson.databind.ext.* *;
}

-keep class com.fasterxml.** { *; }
-dontwarn com.fasterxml.**