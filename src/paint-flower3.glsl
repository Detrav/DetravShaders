#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718
#define ANGLE PI*0.148
#define TWO_PI 6.28318530718
#define SIZE 3

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

vec3 flower(vec2 center, vec2 pos, float angle,
                    float size, vec3 current_color, vec3 color)
{
    vec2 location = center - pos;
    float r = length(location)*2.0;
    float a = (atan(location.y,location.x) - angle) / TWO_PI + 2.125 ;
    
    a = fract(a ) * TWO_PI;

    if(a < PI) return current_color;
    
    float f = sin(a*2.0 )*size ;
    
    
    float pct = 1.0-step(f,r);
    return mix(current_color, color, pct);
    
}

vec3 plaka(vec2 start, vec2 end, vec2 pos, vec3 currentColor, vec3 color)
{
    float f_step = distance(end,start) / float(SIZE + 1);
    vec2 v_step = (end - start) * f_step;
    vec2 center = start;
    float f_angle = atan(v_step.y,v_step.x);
    for(int i =0; i<= SIZE+2; i++)
    {
        currentColor = flower(center, pos, f_angle
                - ANGLE
                ,.5* f_step, currentColor, color);
        currentColor = flower(center, pos, f_angle 
                + ANGLE
                ,0.5 * f_step, currentColor, color);
        center += v_step;
    }
        
    
    return currentColor;
}

vec3 stvol(vec2 start, vec2 end, vec2 pos, vec3 currentColor, vec3 color)
    {
    float f_step = distance(end,start) / float(SIZE+1);
    vec2 v_step = (end - start) * f_step;
    float f_angle = atan(v_step.y,v_step.x);
    vec2 left = vec2(cos(f_angle + ANGLE), sin(f_angle + ANGLE)) / 2.0;
    vec2 right = vec2(cos(f_angle - ANGLE), sin(f_angle - ANGLE)) / 2.0;
    vec2 center = start;
    
    
    for(int i =0; i<= SIZE+1; i++)
    {         
        color = vec3(rand(center),rand(center+ left),rand(center+ right));
        currentColor = plaka(center, center + left, pos, currentColor, color);
        currentColor = plaka(center, center + right, pos, currentColor, color );
        center += v_step;
    }
    return currentColor;
}

vec3 stvol2(vec2 start, vec2 end, vec2 pos, vec3 currentColor, vec3 color)
    {
    float f_step = distance(end,start) / float(SIZE+1);
    vec2 v_step = (end - start) * f_step;
    float f_angle = atan(v_step.y,v_step.x);
    vec2 left = vec2(cos(f_angle + ANGLE), sin(f_angle + ANGLE)) / 2.0;
    vec2 right = vec2(cos(f_angle - ANGLE), sin(f_angle - ANGLE)) / 2.0;
    vec2 center = start;
    
    
    for(int i =0; i<= SIZE; i++)
    {                    
        color = vec3(rand(center),rand(center+ left),rand(center+ right));
        currentColor = stvol(center, center + left, pos, currentColor, color);
        currentColor = stvol(center, center + right, pos, currentColor, color );
        center += v_step;
    }
    return currentColor;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);


    color = stvol2(vec2(0.1), vec2(0.9), st, color, vec3(0.447,0.943,1.000));


        
    

    gl_FragColor = vec4(color, 1.0);
}
