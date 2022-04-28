#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

vec2 rotate2d(vec2 point, mat2 matrix, vec2 origin)
{
    point -= vec2(0.5);
    point = matrix * point;
    point += vec2(0.5);   
    return point;
}

vec2 rotate2d(vec2 point, float angle, vec2 origin)
{
    mat2 matrix = rotate2d(angle);
    return rotate2d(point, matrix, origin);
}

vec2 translate2d(vec2 point, vec2 offset)
{
    return point - offset;
}

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float cross(in vec2 _st, float _size){
    return  box(_st, vec2(_size,_size/4.)) +
            box(_st, vec2(_size/4.,_size));
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
    
    st = translate2d(st, vec2(-0.2, 0.1));
    st = rotate2d(st,  sin(u_time)*PI, vec2(0.5));
    
    //color = vec3(st,0);
    
    color += vec3(cross(st,0.4));

    gl_FragColor = vec4(color,1.0);
}
