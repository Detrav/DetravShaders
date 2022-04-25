#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 rect_outline(vec2 from, vec2 to, float width, vec3 current, vec2 pos, vec3 newval)
{
    vec2 bl = step(from-width/2.0,pos);
    vec2 tr = step(1.0-to-width/2.0,1.0-pos); 
    vec2 bl2 = step(from+width/2.0,pos);
    vec2 tr2 = step(1.0-to+width/2.0,1.0-pos); 
    
    float ptc =  bl.x * bl.y * tr.x * tr.y - bl2.x * bl2.y * tr2.x * tr2.y;
    return mix(current, newval, ptc);
}

mat2 rotation2d(float angle) {
	float s = sin(angle);
	float c = cos(angle);

	return mat2(
		c, -s,
		s, c
	);
}

void main(){
    vec2 st = fract(gl_FragCoord.xy/u_resolution.xy * 1.);
    vec3 color = vec3(0.0);
    
    st = rotation2d(u_time) * (st- 0.5) + 0.5;
     
    // 678 x 794
    
    color = rect_outline(
        vec2(0.1), vec2(0.6), 0.02,
        color, st, vec3(1.0,0.0,0.0));
    
    color = rect_outline(
        vec2(0.4), vec2(0.9), 0.02,
        color, st, vec3(0.0,1.0,0.0));

    gl_FragColor = vec4(color,1.0);
}
