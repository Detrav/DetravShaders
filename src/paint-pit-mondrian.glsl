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
    
    // 678 x 794
    vec2 res = vec2(794.0, 794.0);
        
    
    color = rect(
        vec2(0.0/res.x,(res.y-125.0)/res.y),
        vec2(44.0/res.x,(res.y-0.0)/res.y), 
        color, st, vec3(159.0/255.0,30.0/255.0,34.0/255.0));
    
    color = rect(
        vec2(0.0/res.x,(res.y-279.0)/res.y),
        vec2(46.0/res.x,(res.y-149.0)/res.y), 
        color, st, vec3(159.0/255.0,30.0/255.0,34.0/255.0));
    
    color = rect(
        vec2(62.0/res.x,(res.y-126.0)/res.y),
        vec2(145.0/res.x,(res.y-0.0)/res.y), 
        color, st, vec3(159.0/255.0,30.0/255.0,34.0/255.0));
    
    color = rect(
        vec2(60.0/res.x,(res.y-277.0)/res.y),
        vec2(144.0/res.x,(res.y-149.0)/res.y), 
        color, st, vec3(159.0/255.0,30.0/255.0,34.0/255.0));
    
    
    color = rect(
        vec2(163.0/res.x,(res.y-126.0)/res.y),
        vec2(496.0/res.x,(res.y-0.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(516.0/res.x,(res.y-125.0)/res.y),
        vec2(645.0/res.x,(res.y-0.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(164.0/res.x,(res.y-279.0)/res.y),
        vec2(498.0/res.x,(res.y-149.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(517.0/res.x,(res.y-276.0)/res.y),
        vec2(642.0/res.x,(res.y-150.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    
    color = rect(
        vec2(0.0/res.x,(res.y-794.0)/res.y),
        vec2(143.0/res.x,(res.y-302.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(164.0/res.x,(res.y-720.0)/res.y),
        vec2(498.0/res.x,(res.y-303.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(163.0/res.x,(res.y-794.0)/res.y),
        vec2(498.0/res.x,(res.y-737.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(516.0/res.x,(res.y-717.0)/res.y),
        vec2(642.0/res.x,(res.y-298.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    color = rect(
        vec2(657.0/res.x,(res.y-717.0)/res.y),
        vec2(678.0/res.x,(res.y-300.0)/res.y), 
        color, st, vec3(237.0/255.0,228.0/255.0,211.0/255.0));
    
    
    color = rect(
        vec2(659.0/res.x,(res.y-276.0)/res.y),
        vec2(678.0/res.x,(res.y-149.0)/res.y), 
        color, st, vec3(252.0/255.0,196.0/255.0,59.0/255.0));
    
    color = rect(
        vec2(659.0/res.x,(res.y-124.0)/res.y),
        vec2(678.0/res.x,(res.y-0.0)/res.y), 
        color, st, vec3(252.0/255.0,196.0/255.0,59.0/255.0));
    
    
    color = rect(
        vec2(514.0/res.x,(res.y-794.0)/res.y),
        vec2(641.0/res.x,(res.y-738.0)/res.y), 
        color, st, vec3(1.0/255.0,95.0/255.0,156.0/255.0));
    
    color = rect(
        vec2(657.0/res.x,(res.y-794.0)/res.y),
        vec2(678.0/res.x,(res.y-738.0)/res.y), 
        color, st, vec3(1.0/255.0,95.0/255.0,156.0/255.0));
    
    //678.0
    color = rect(
        vec2(678.0/res.x,(res.y-794.0)/res.y),
        vec2(res.x/res.x,(res.y-0.0)/res.y), 
        color, st, vec3(236.0/255.0,236.0/255.0,236.0/255.0));

    
    gl_FragColor = vec4(color,1.0);
}
