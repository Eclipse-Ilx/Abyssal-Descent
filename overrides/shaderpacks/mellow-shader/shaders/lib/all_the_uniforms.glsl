uniform float viewWidth;
uniform float viewHeight;
uniform int isEyeInWater;
uniform float frameTimeCounter;
uniform float frameTime;
uniform int frameCounter;
uniform vec3 fogColor;
uniform vec3 cameraPosition;
uniform vec4 entityColor;
uniform int worldTime;
uniform float rainStrength;
uniform float temperature;
uniform vec3 sunPosition;
uniform int worldDay;
uniform int heldBlockLightValue;
uniform float darknessFactor;
uniform float darknessLightFactor;
uniform float blindness;
uniform ivec2 eyeBrightnessSmooth;
uniform vec3 previousCameraPosition;
uniform int entityId;
uniform float nightVision;
uniform float sunAngleAtHome;
uniform float screenBrightness;
uniform int renderStage;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D gaux1;
uniform sampler2D colortex5;
uniform sampler2D depthtex0;
uniform sampler2D depthtex1;
uniform sampler2D noisetex;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferProjection;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferPreviousProjection;

uniform float near;
uniform float far;

flat varying vec3 SUN_DIRECT;
flat varying vec3 SUN_AMBIENT;
flat varying vec3 SKY_TOP;
flat varying vec3 SKY_GROUND;

uniform float timeAngle;
uniform float nightStrength;
uniform float dayStrength;
uniform float sunsetStrength;
uniform float sunriseStrength;
uniform vec2 resolution;
uniform vec2 resolutionInv;
uniform vec3 sunOrMoonPosN;
uniform vec3 sunPosN;
uniform vec2 taaJitter;
uniform float isOutdoorsSmooth;
uniform float precipitationSmooth;

uniform float dhFarPlane;
uniform float dhNearPlane;

uniform sampler2D dhDepthTex;
uniform sampler2D dhDepthTex1;

uniform mat4 dhProjectionInverse;
uniform mat4 dhProjection;
uniform mat4 dhPreviousProjection;

uniform int dhRenderDistance;

const bool colortex0Clear = false;
const bool colortex1Clear = false;
const bool colortex2Clear = false;
const bool colortex3Clear = false;
const bool gaux1Clear = false;
const bool colortex5Clear = false;

const int noiseTextureResolution = 256;

/*
const int colortex0Format = R11F_G11F_B10F;
const int colortex1Format = R11F_G11F_B10F;
const int colortex2Format = RGBA8;
const int gaux1Format = R11F_G11F_B10F;
*/
