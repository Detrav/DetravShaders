#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 rect(vec2 from, vec2 to, vec2 point)
{
    vec2 bl = step(from,point);
    float pct = bl.x * bl.y;
    
    vec2 tr = step(1.0-to,1.0-point); 
    return vec3(bl.x * bl.y * tr.x * tr.y);
}

void main(){
    vec2 st = fract(gl_FragCoord.xy/u_resolution.xy * 1.) ;
    vec3 color = rect(vec2(0.1,0.1),vec2(0.9,0.9), st);

    gl_FragColor = vec4(color,1.0);
}
