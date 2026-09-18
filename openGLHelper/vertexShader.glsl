#version 150

in vec3 position;
in vec4 color;

in vec3 posLeft;
in vec3 posRight;
in vec3 posUp;
in vec3 posDown;

out vec4 col;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

//mode 1 is used for the smooth triangles mode (key 4)
uniform int mode;

//Only used when mode == 1.
uniform float scale;
uniform float exponent;

void main()
{
  vec3 finalPosition = position;
  vec4 finalColor = color;

  if (mode == 1)
  {
    vec3 avgPosition = (position + posLeft + posRight + posUp + posDown) / 5.0f;

    float y = avgPosition.y;
    float remapped = pow(y, exponent);

    finalColor = vec4(remapped, remapped, remapped, 1.0f);

    finalPosition = vec3(avgPosition.x, scale * remapped, avgPosition.z);
  }

  gl_Position = projectionMatrix * modelViewMatrix * vec4(finalPosition, 1.0f);
  col = finalColor;
}

