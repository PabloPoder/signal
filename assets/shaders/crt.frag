#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform sampler2D uTexture;
uniform float uTime;

out vec4 fragColor;

void main() {

    vec2 uv = FlutterFragCoord().xy / uSize;
    vec2 originalUV = uv;

    // -------------------------
    // BARREL DISTORTION
    // -------------------------

    vec2 centered = uv - 0.5;

    float dist = dot(centered, centered);

    centered.x *= 1.0 + dist * 0.15;
    centered.y *= 1.0 + dist * 0.22;

    uv = centered + 0.5;

    // -------------------------
    // OUT OF BOUNDS
    // -------------------------

    if (
        uv.x < 0.0 || uv.x > 1.0 ||
        uv.y < 0.0 || uv.y > 1.0
    ) {
        fragColor = vec4(0.0);
        return;
    }

    // -------------------------
    // PIXEL SIZE
    // -------------------------

    float px = 1.0 / uSize.x;

    // -------------------------
    // CRT JITTER
    // -------------------------

    uv.x +=
        sin(uv.y * 80.0 + uTime * 2.0)
        * 0.0006;

    // -------------------------
    // CHROMATIC ABERRATION
    // -------------------------

    float chroma =
        pow(dist, 1.8) * 0.0012;

    vec2 chromaOffset =
        centered * chroma;

    float r = texture(
        uTexture,
        uv + chromaOffset
    ).r;

    float g = texture(
        uTexture,
        uv
    ).g;

    float b = texture(
        uTexture,
        uv - chromaOffset
    ).b;

    vec4 color = vec4(r, g, b, 1.0);

    // -------------------------
    // CRT PHOSPHOR GLOW
    // -------------------------

    vec3 glow = vec3(0.0);

    float glowStrength = 0.26;
    float glowRadius = px * 1.2;

    glow += texture(
        uTexture,
        uv + vec2(glowRadius, 0.0)
    ).rgb;

    glow += texture(
        uTexture,
        uv - vec2(glowRadius, 0.0)
    ).rgb;

    glow += texture(
        uTexture,
        uv + vec2(0.0, glowRadius * 0.5)
    ).rgb;

    glow += texture(
        uTexture,
        uv - vec2(0.0, glowRadius * 0.5)
    ).rgb;

    glow += texture(
        uTexture,
        uv + vec2(glowRadius * 2.5, 0.0)
    ).rgb * 0.25;

    glow *= 0.18;

    float edge =
        smoothstep(0.2, 1.0, dist);

    glowStrength += edge * 0.04;

    color.rgb += glow * glowStrength;

    // -------------------------
    // LUMINANCE
    // -------------------------

    float luminance =
        dot(
            color.rgb,
            vec3(0.299, 0.587, 0.114)
        );

    // -------------------------
    // CRT HORIZONTAL BLEED
    // -------------------------

    vec3 bleed = vec3(0.0);

    bleed += texture(
        uTexture,
        uv + vec2(px * 0.8, 0.0)
    ).rgb * 0.32;

    bleed += texture(
        uTexture,
        uv + vec2(px * 1.6, 0.0)
    ).rgb * 0.18;

    bleed += texture(
        uTexture,
        uv + vec2(px * 3.2, 0.0)
    ).rgb * 0.08;

    bleed += texture(
        uTexture,
        uv + vec2(px * 5.5, 0.0)
    ).rgb * 0.03;

    float bleedMask =
        smoothstep(0.35, 0.95, luminance);

    color.rgb +=
        bleed
        * bleedMask
        * 0.20;

    // -------------------------
    // CRT SOFT FOCUS
    // -------------------------

    float focusMask =
        smoothstep(0.2, 1.0, luminance);

    color.rgb *= 0.965;

    color.rgb += texture(
        uTexture,
        uv + vec2(px * 0.45, 0.0)
    ).rgb * 0.018 * focusMask;

    color.rgb += texture(
        uTexture,
        uv - vec2(px * 0.45, 0.0)
    ).rgb * 0.018 * focusMask;

    // -------------------------
// FAKE CRT GHOSTING
// -------------------------

vec3 ghost = vec3(0.0);

ghost += texture(
    uTexture,
    uv - vec2(px * 0.7, 0.0)
).rgb * 0.18;

ghost += texture(
    uTexture,
    uv - vec2(px * 1.8, 0.0)
).rgb * 0.10;

ghost += texture(
    uTexture,
    uv - vec2(px * 3.2, 0.0)
).rgb * 0.04;

float ghostMask =
    smoothstep(0.45, 1.0, luminance);

color.rgb +=
    ghost
    * ghostMask
    * 0.12;

    // -------------------------
    // CRT SCANLINES
    // -------------------------

    float scanUV =
        mix(originalUV.y, uv.y, 0.18);

    float lines =
        sin(scanUV * uSize.y * 1.15);

    lines = lines * 0.5 + 0.5;

    float scan =
        1.0 - lines;

    float lineStrength = 0.075;

    vec3 phosphorColor =
        mix(
            vec3(0.25, 1.0, 0.35),
            color.rgb,
            0.65
        );

    color.rgb *=
        1.0 - (scan * 0.08);

    color.rgb +=
        phosphorColor
        * scan
        * lineStrength;

    color.rgb +=
        color.rgb
        * scan
        * 0.018;

    // -------------------------
    // VIGNETTE
    // -------------------------

    float vignette =
        1.0 - dist * 1.15;

    color.rgb *= vignette;

    // -------------------------
    // FLICKER
    // -------------------------

    float flicker =
        sin(uTime * 12.0) * 0.006;

    color.rgb += flicker;

    // -------------------------
    // BEAM INSTABILITY
    // -------------------------

    float beam =
        sin(uv.y * 2.0 + uTime * 0.4)
        * 0.015;

    color.rgb *= 1.0 + beam;

    // -------------------------
    // ANALOG NOISE
    // -------------------------

    float noise =
        fract(
            sin(
                dot(
                    FlutterFragCoord().xy,
                    vec2(12.9898, 78.233)
                )
            ) * 43758.5453
        );

    noise = (noise - 0.5) * 0.012;

    color.rgb += noise;

    // -------------------------
    // FINAL CLAMP
    // -------------------------

    color.rgb =
        clamp(color.rgb, 0.0, 1.0);

    fragColor = color;
}