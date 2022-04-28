#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 flower_outline(vec2 center, vec2 pos, float angle,
            float width, float min_radius, float max_radius,
            float petal_count, vec3 current_color, vec3 color)
{
    vec2 location = center - pos;
    float r = length(location)*2.0;
    float a = atan(location.y,location.x) + angle;
    
    float dr = max_radius - min_radius;
    
    float f = pow(
        //cos(a*petal_count/4.) +
        sin(a*petal_count/8.)
        ,2.) * dr + min_radius;
    
    
    float pct = step(f-width/2.0,r) - step(f+width/2.0,r);
    return mix(current_color, color, pct);
    
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    st = fract(st*3.0);
    vec3 color = vec3(0.0);

    vec2 pos = vec2(0.5)-st;
    
    for(int i =0 ; i<200; i++)
        {

    color = flower_outline(vec2(0.5), st, u_time + float(i)*TWO_PI, 0.03, 0.2, 0.8,5.0, color, vec3(0.020,1.000,0.990));
    }

        
    

    gl_FragColor = vec4(color, 1.0);
}
