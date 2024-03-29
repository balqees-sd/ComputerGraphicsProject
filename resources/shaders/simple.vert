#version 150
#extension GL_ARB_explicit_attrib_location : require
// vertex attributes of VAO
layout(location = 0) in vec3 in_Position;
layout(location = 1) in vec3 in_Normal;
layout(location = 2) in vec2 in_TexCoord;

//Matrix Uniforms as specified with glUniformMatrix4fv
uniform mat4 ModelMatrix;
uniform mat4 ViewMatrix;
uniform mat4 ProjectionMatrix;
uniform mat4 NormalMatrix;

out vec3 pass_Normal, pass_Position, pass_Camera_Position;
out mat4 pass_ViewMatrix, pass_ModelMatrix, pass_NormalMatrix;
out vec2 pass_TexCoord;

void main(void)
{
	gl_Position = (ProjectionMatrix  * ViewMatrix * ModelMatrix) * vec4(in_Position, 1.0);
	pass_Camera_Position = (inverse(transpose(ViewMatrix)) * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
	pass_Position = ((ViewMatrix * ModelMatrix) * vec4(in_Position, 1.0)).xyz; 
	pass_ModelMatrix = ModelMatrix;
	pass_ViewMatrix = ViewMatrix;
	pass_Normal = mat3(NormalMatrix) * in_Normal;
	pass_NormalMatrix = NormalMatrix;
	pass_TexCoord = in_TexCoord;
	
}
