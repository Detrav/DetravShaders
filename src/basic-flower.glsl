#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 flower(vec2 center, vec2 pos, float angle,
            float min_radius, float max_radius,
            float petal_count, vec3 current_color, vec3 color)
{
    vec2 location = center - pos;
    float r = length(location)*2.0;
    float a = atan(location.y,location.x) + angle;
    
    float dr = max_radius - min_radius;
    
    float f = pow(cos(a*petal_count/2.0),2.) * dr + min_radius;
    
    
    
    return mix(current_color, color, 1.-step(f,r));
    
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec2 pos = vec2(0.5)-st;

    color = flower(vec2(0.43), st, u_time, 0.2, 0.8,5.0, color, vec3(0.020,1.000,0.990));

    gl_FragColor = vec4(color, 1.0);
}
