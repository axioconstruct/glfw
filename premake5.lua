-- premake5.lua build config for creating a static glfw library
-- adapter from glfw CMakeLists.txt
project "GLFW"
  kind "StaticLib"
  language "C"
  staticruntime "off"

  targetdir ("%{wks.location}/bin/" .. outputdir .. "/")
  objdir ("%{wks.location}/obj/" .. outputdir .. "/")

  -- core sources
  files = {
    "include/GLFW/glfw3.h",
    "include/GLFW/glfw3native.h",

    "internal.h",
    "platform.h",
    "mappings.h",
  
    "context.c",
    "init.c",
    "input.c",
    "monitor.c",
    "platform.c",
    "vulkan.c",
    "window.c",
    
    "egl_context.c",
    "osmesa_context.c",
    "null_platform.h",
    "null_joystick.h",
  
    "null_init.c",
    "null_monitor.c",
    "null_window.c",
    "null_joystick.c"
  }

  filter "system:linux"
    -- generate position independent code, in which the static lib can be linked to dynamic libs
    pic "on"
    systemversion "latest"
    cppdialect "C++17"

    -- linux-specific sources
    files = {
      "posix_time.h",
      "posix_thread.h",
    
      "posix_module.c",
      "posix_time.c",
      "posix_thread.c",

      "xkb_unicode.h",
      "xkb_unicode.c",
  
    -- GLFW_BUILD_X11
      "x11_platform.h",
      "x11_init.c",
      "x11_monitor.c",
      "x11_window.c",
      "glx_context.c",

    -- GLFW_BUILD_WAYLAND
      --"wl_platform.h",
      --"wl_init.c",
      --"wl_monitor.c",
      --"wl_window.c" 
    }

    defines {
      "_GLFW_X11"
      --"_GLFW_WAYLAND
      -- wayland build is more intricate and will need to be adapted. Therefore commented out for now.
    } 

  filter "configurations:Debug"
    runtime "Debug"
    symbols "on"

  filter "configurations:Release"
    runtime "Release"
    optimize "on"

	--filter "configurations:Dist"
	--	runtime "Release"
	--	optimize "on"
  --      symbols "off"
