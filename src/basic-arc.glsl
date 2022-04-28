#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.1, pct, st.y) -
          smoothstep( pct, pct+0.1, st.y);
}

vec3 draw_arc(in vec2 point,
              in float radius, in  vec2 center, in float start_angle,in  float end_angle, in float width,
              in vec3 currentColor, in  vec3 color )
{
    point = center - point;
    float r = length(point);
    float a = fract( atan(point.y,point.x) / TWO_PI + 2.5  ) * TWO_PI ;
    
    return mix(currentColor,  color , 
            step(start_angle,a) 
               *
            (1.0 - step(end_angle,a)) 
               *
            (step(radius - width/ 2.0,r)- step(radius + width / 2.0,r))
              );
    
}

vec3 circle_outline(vec2 pos,float width, float radius, vec2 center, vec3 current_color, vec3 stroke_color)
{
    vec2 tC = center-pos;
    float r1 = radius * 2.0 - width /2.0;
    float r2 = radius * 2.0 + width /2.0;
    float dist = tC.x*tC.x+tC.y*tC.y;
    return mix(current_color, stroke_color,
        step(0.25*r1*r1, dist) - step(0.25*r2*r2, dist));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    
    vec3 color = vec3(0.0);
    
    color = circle_outline(st, 0.02, 0.45, vec2(0.5), color, vec3(1.0,0.0,0.0));
    color = draw_arc(st, .45, vec2(0.5), 0.0, PI /3.0 , 0.02, color, vec3(1.0,1.0,0.0));

    gl_FragColor = vec4(color,1.0);
}
