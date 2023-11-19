-- premake5.lua build config for creating a static glfw library
-- adapter from glfw CMakeLists.txt
project "GLFW"
  kind "StaticLib"
  language "C"
  staticruntime "off"

  targetdir ("bin/" .. outputdir .. "/%{prj.name}")
  objdir ("obj/" .. outputdir .. "/%{prj.name}")

  -- core sources
  files {
    "include/GLFW/glfw3.h",
    "include/GLFW/glfw3native.h",

    "src/internal.h",
    "src/platform.h",
    "src/mappings.h",
  
    "src/context.c",
    "src/init.c",
    "src/input.c",
    "src/monitor.c",
    "src/platform.c",
    "src/vulkan.c",
    "src/window.c",
    
    "src/egl_context.c",
    "src/osmesa_context.c",
    "src/null_platform.h",
    "src/null_joystick.h",
  
    "src/null_init.c",
    "src/null_monitor.c",
    "src/null_window.c",
    "src/null_joystick.c"
  }

  filter "system:linux"
    -- generate position independent code, in which the static lib can be linked to dynamic libs
    pic "on"
    systemversion "latest"
    cppdialect "C++17"

    -- linux-specific sources
    files {
      "src/posix_time.h",
      "src/posix_thread.h",
    
      "src/posix_module.c",
      "src/posix_time.c",
      "src/posix_thread.c",

      "src/xkb_unicode.h",
      "src/xkb_unicode.c",
  
    -- GLFW_BUILD_X11
      "src/x11_platform.h",
      "src/x11_init.c",
      "src/x11_monitor.c",
      "src/x11_window.c",
      "src/glx_context.c",

    -- GLFW_BUILD_WAYLAND
      --"wl_platform.h",
      --"wl_init.c",
      --"wl_monitor.c",
      --"wl_window.c" 

    -- if wayland or x11 and systemname == "Linux"
      "linux_joystick.h",
      "linux_joystick.c",
    -- if wayland of x11
      "posix_poll.h",
      "posix_poll.c",
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
