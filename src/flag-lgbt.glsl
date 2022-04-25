#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 rect(vec2 from, vec2 to, vec3 current, vec2 pos, vec3 newval)
{
    vec2 bl = step(from,pos);
    float pct = bl.x * bl.y;
    
    vec2 tr = step(1.0-to,1.0-pos); 
    float ptc =  bl.x * bl.y * tr.x * tr.y;
    return mix(current, newval, ptc);
}

void main(){
    vec2 st = fract(gl_FragCoord.xy/u_resolution.xy * 1.);
    vec3 color = vec3(0.0);
        
    
    color = rect(
        vec2(0.1,0.1 + 6.0*(0.8/7.0)),
        vec2(0.9,0.1 + 7.0*(0.8/7.0)), 
        color, st, vec3(1.0,0.0,0.0));
    color = rect(
        vec2(0.1,0.1 + 5.0*(0.8/7.0)),
        vec2(0.9,0.1 + 6.0*(0.8/7.0)), 
        color, st, vec3(1.0,0.647,0.0));
    color = rect(
        vec2(0.1,0.1 + 4.0*(0.8/7.0)),
        vec2(0.9,0.1 + 5.0*(0.8/7.0)), 
        color, st, vec3(1.0,1.0,0.0));
    color = rect(
        vec2(0.1,0.1 + 3.0*(0.8/7.0)),
        vec2(0.9,0.1 + 4.0*(0.8/7.0)), 
        color, st, vec3(0.0,1.0,0.0));
    color = rect(
        vec2(0.1,0.1 + 2.0*(0.8/7.0)),
        vec2(0.9,0.1 + 3.0*(0.8/7.0)), 
        color, st, vec3(0.0,1.0,1.0));
    color = rect(
        vec2(0.1,0.1 + 1.0*(0.8/7.0)),
        vec2(0.9,0.1 + 2.0*(0.8/7.0)), 
        color, st, vec3(0.0,0.0,1.0));
    color = rect(
        vec2(0.1,0.1 + 0.0*(0.8/7.0)),
        vec2(0.9,0.1 + 1.0*(0.8/7.0)), 
        color, st, vec3(1.0,0.0,1.0));
    
    gl_FragColor = vec4(color,1.0);
}
