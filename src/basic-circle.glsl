#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 circle(vec2 pos,float radius, vec2 center,
             vec3 current_color, vec3 stroke_color)
{
    vec2 tC = center-pos;
    return mix(current_color, stroke_color, 1.0 - step(0.25*radius*radius, tC.x*tC.x+tC.y*tC.y));
}

vec3 circle_outline(vec2 pos,float width, float radius, vec2 center, vec3 current_color, vec3 stroke_color)
{
    vec2 tC = center-pos;
    float r1 = radius - width /2.0;
    float r2 = radius + width /2.0;
    float dist = tC.x*tC.x+tC.y*tC.y;
    return mix(current_color, stroke_color,
        step(0.25*r1*r1, dist) - step(0.25*r2*r2, dist));
}

/* radius? mb D?
vec3 circle_outline(vec2 pos,float width, float radius, vec2 center, vec3 current_color, vec3 stroke_color)
{
    vec2 tC = center-pos;
    float r1 = radius * 2.0 - width /2.0;
    float r2 = radius * 2.0 + width /2.0;
    float dist = tC.x*tC.x+tC.y*tC.y;
    return mix(current_color, stroke_color,
        step(0.25*r1*r1, dist) - step(0.25*r2*r2, dist));
}
*/

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);
    color = circle(st, 0.5, vec2(0.25), color, vec3(1.0,0.0,0.0));
    color = circle_outline(st,0.03, 0.5, vec2(0.75-0.03/2.0), color, vec3(0.0,1.0,0.0));

	gl_FragColor = vec4( color, 1.0 );
}
