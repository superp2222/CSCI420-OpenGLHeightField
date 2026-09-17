# CSCI 420 Assignment 1 — OpenGL Height Field

Starter project for USC CSCI 420 Assignment 1. The supplied code loads a JPEG
heightmap and currently renders a single RGB triangle as a setup test.

## Repository layout

```text
CSCI420-OpenGLHeightField/
├── external/          Third-party headers, libraries, and DLLs
├── hw1/               Visual Studio solution, source, and heightmaps
│   ├── heightmap/
│   ├── hw1.cpp
│   └── hw1.sln
└── openGLHelper/      OpenGL helper code and GLSL shaders
```

Do not move or rename these directories. The Visual Studio project uses their
relative paths.

## One-time Windows setup

1. Install the current **Visual Studio Community** from:
   <https://visualstudio.microsoft.com/downloads/>
2. In Visual Studio Installer, select the **Desktop development with C++**
   workload.
3. In the workload's installation details, make sure these are selected:
   - The current MSVC C++ x64/x86 build tools
   - A current Windows 10 or Windows 11 SDK
4. Under **Individual components**, install **MSVC v141 — VS 2017 C++ x64/x86
   build tools** if it is available. The starter project requests `v141`.
5. Complete the installation and restart Windows if requested.

Visual Studio can be modified later by opening **Visual Studio Installer** and
selecting **Modify**, or from Visual Studio through **Tools > Get Tools and
Features**.

## Clone and open the project

### Through Visual Studio

1. Launch Visual Studio.
2. Select **Clone a repository**.
3. Enter:

   ```text
   https://github.com/superp2222/CSCI420-OpenGLHeightField.git
   ```

4. Sign in to GitHub when prompted and choose a local folder.
5. Open `hw1/hw1.sln` from the cloned repository.

### Through Git

```powershell
git clone https://github.com/superp2222/CSCI420-OpenGLHeightField.git
cd CSCI420-OpenGLHeightField
start hw1\hw1.sln
```

Because the repository is private, GitHub authentication is required.

## First launch: update the old project if required

The supplied solution targets:

- Platform: **Win32**
- Platform toolset: **Visual Studio 2017 (`v141`)**
- Windows SDK: **10.0.17763.0**

The bundled GLEW, FreeGLUT, and JPEG libraries are 32-bit. Keep the solution on
**Win32/x86**. Do not switch it to x64 unless all bundled dependencies are also
replaced with 64-bit versions.

### If Visual Studio reports that Windows SDK 10.0.17763.0 is missing

1. In Solution Explorer, right-click the solution `hw1`.
2. Select **Retarget solution** or **Retarget projects**.
3. Select the newest installed Windows SDK.
4. Confirm the change.

### If Visual Studio reports `MSB8020` or says toolset `v141` is missing

Preferred fix:

1. Open **Tools > Get Tools and Features**.
2. Select **Individual components**.
3. Search for `v141`.
4. Install **MSVC v141 — VS 2017 C++ x64/x86 build tools**.

Fallback if `v141` is unavailable:

1. Right-click the `hw1` project and select **Properties**.
2. Set **Configuration** to **All Configurations** and **Platform** to
   **Win32**.
3. Open **Configuration Properties > General**.
4. Change **Platform Toolset** to the current installed MSVC toolset.
5. Apply the change and rebuild.

Retargeting the SDK or toolset modifies project files. Commit those changes only
if the updated project still runs correctly and they are meant to be shared.

## Configure the run arguments

The program requires one command-line argument: the path to a JPEG heightmap.
Without it, the program exits with `usage: ./hw1 <heightmap file>`.

The supplied `hw1.vcxproj.user` may already contain the correct argument. Verify
it once:

1. In Solution Explorer, right-click the `hw1` project and select
   **Properties**.
2. Select **Configuration: Debug** and **Platform: Win32**.
3. Open **Configuration Properties > Debugging**.
4. Set **Command Arguments** to:

   ```text
   .\heightmap\Heightmap.jpg
   ```

5. Set **Working Directory** to:

   ```text
   $(ProjectDir)
   ```

6. Select **Apply**, then **OK**.

Other supplied images can be used by replacing the command argument, for
example:

```text
.\heightmap\GrandTeton-128.jpg
```

## Build and run

Each time the project is opened:

1. Set the toolbar configuration to **Debug**.
2. Set the platform to **Win32** or **x86**—not x64.
3. In Solution Explorer, right-click `hw1` and choose **Set as Startup Project**
   if it is not already bold.
4. Build with **Build > Build Solution** or `Ctrl+Shift+B`.
5. Run with **Debug > Start Debugging** or `F5`.

For the untouched starter code, success means:

- The console prints the OpenGL version, renderer, and shading-language version.
- It prints `Successfully built the pipeline program.`
- A 1280×720 window titled **CSCI 420 Homework 1** appears.
- A triangle with blue, red, and green vertices appears on a black background.

Use `Ctrl+F5` to run without attaching the debugger.

## Run from PowerShell after building

From the repository root:

```powershell
cd hw1
.\Bin\Debug\hw1.exe .\heightmap\Heightmap.jpg
```

For a Release build:

```powershell
cd hw1
.\Bin\Release\hw1.exe .\heightmap\Heightmap.jpg
```

## Starter-code controls

| Input | Behavior |
| --- | --- |
| `Esc` | Exit the program |
| `Space` | Print a message in the console |
| `x` | Save `screenshot.jpg` in the working directory |
| Left-drag | Update x/y rotation values |
| Middle-drag | Update z rotation values |
| `Ctrl` + drag | Update translation values |
| `Shift` + drag | Update scale values |

The starter code records the mouse transformations but does not yet apply them
to the triangle. They become visibly useful after the assignment's terrain
transformations are implemented.

## Troubleshooting

### `The Windows SDK version 10.0.17763.0 was not found`

Retarget the solution to an installed SDK as described above.

### `MSB8020: The build tools for v141 cannot be found`

Install the `v141` component or retarget the Platform Toolset to the current
MSVC toolset.

### Linker cannot find `glew32`, `freeglut`, or `jpeg`

- Confirm the platform is **Win32/x86**, not x64.
- Confirm the complete `external/` directory was cloned.
- Confirm `hw1/vs2017.props` still exists.
- Do not remove the bundled `.lib` files from Git.

### Windows cannot find `glew32d.dll` or `freeglutd.dll`

Confirm these files exist for a Debug build:

```text
hw1/Bin/Debug/glew32d.dll
hw1/Bin/Debug/freeglutd.dll
```

For Release, confirm `glew32.dll` and `freeglut.dll` exist in
`hw1/Bin/Release/`.

### Program prints `The arguments are incorrect`

Set the heightmap under **Project Properties > Debugging > Command Arguments**.

### Program prints `Error reading image`

Confirm the working directory is `$(ProjectDir)` and that the requested image
exists under `hw1/heightmap/`.

### Shader files cannot be found or compiled

Confirm `openGLHelper/vertexShader.glsl` and
`openGLHelper/fragmentShader.glsl` exist, and preserve the original repository
layout.

### OpenGL window fails to appear

Update the PC's NVIDIA, AMD, or Intel graphics driver, then run again. Also read
the console output for the GLEW or shader error that occurred before the window
closed.

## Normal Git workflow

Before beginning a work session:

```powershell
git pull
```

After making and testing changes:

```powershell
git status
git add .
git commit -m "Describe the change"
git push
```

Avoid committing generated executables, intermediate build files, `.vs/`, or
Visual Studio database files. Keep the supplied dependency DLLs and libraries
tracked.

## Official setup references

- [Visual Studio downloads](https://visualstudio.microsoft.com/downloads/)
- [Install C and C++ support in Visual Studio](https://learn.microsoft.com/en-us/cpp/build/vscpp-step-0-installation)
- [Modify Visual Studio workloads and components](https://learn.microsoft.com/en-us/visualstudio/install/modify-visual-studio)
- [Upgrade C++ projects from earlier Visual Studio versions](https://learn.microsoft.com/en-us/cpp/porting/upgrading-projects-from-earlier-versions-of-visual-cpp)


# Successfully pulled and set up!