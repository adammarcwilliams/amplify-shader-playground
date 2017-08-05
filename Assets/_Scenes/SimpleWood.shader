// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SimpleWood"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_WoodDiffuse("WoodDiffuse", 2D) = "white" {}
		_WoodNormal("WoodNormal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _WoodNormal;
		uniform float4 _WoodNormal_ST;
		uniform sampler2D _WoodDiffuse;
		uniform float4 _WoodDiffuse_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_WoodNormal = i.uv_texcoord * _WoodNormal_ST.xy + _WoodNormal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _WoodNormal, uv_WoodNormal ) );
			float2 uv_WoodDiffuse = i.uv_texcoord * _WoodDiffuse_ST.xy + _WoodDiffuse_ST.zw;
			o.Albedo = tex2D( _WoodDiffuse, uv_WoodDiffuse ).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=12001
808;92;1112;926;794.2;504.6;1.3;False;False
Node;AmplifyShaderEditor.SamplerNode;1;-511.5,-222;Float;True;Property;_WoodDiffuse;WoodDiffuse;0;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/SceneTextures/WoodDiffuse.tif;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;2;-512.2998,6.200008;Float;True;Property;_WoodNormal;WoodNormal;1;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/SceneTextures/WoodNormal.tif;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-88,-128;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;SimpleWood;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1;0
WireConnection;0;1;2;0
ASEEND*/
//CHKSM=994E0210981F574C599E2738803C7DE559B09B85