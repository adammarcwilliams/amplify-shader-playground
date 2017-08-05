// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "InvisibleRipples"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		_Blending("Blending", Range( 0 , 1)) = 0
		_DistortionMap("DistortionMap", 2D) = "bump" {}
		_DistortionScale("DistortionScale", Range( 0 , 1)) = 0
		_RippleScale("RippleScale", Range( 0 , 20)) = 0
		_RippleSpeed("RippleSpeed", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ "GrabScreen0" }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
		};

		uniform sampler2D GrabScreen0;
		uniform sampler2D _DistortionMap;
		uniform float _RippleScale;
		uniform float _RippleSpeed;
		uniform float _DistortionScale;
		uniform float _Blending;
		uniform float _MaskClipValue = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = float3(0,0,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPos7 = ase_screenPos;
			#if UNITY_UV_STARTS_AT_TOP
			float scale7 = -1.0;
			#else
			float scale7 = 1.0;
			#endif
			float halfPosW7 = ase_screenPos7.w * 0.5;
			ase_screenPos7.y = ( ase_screenPos7.y - halfPosW7 ) * _ProjectionParams.x* scale7 + halfPosW7;
			#ifdef UNITY_SINGLE_PASS_STEREO
			ase_screenPos7.xy = TransformStereoScreenSpaceTex(ase_screenPos7.xy, ase_screenPos7.w);
			#endif
			ase_screenPos7.xyzw /= ase_screenPos7.w;
			float4 screenColor2 = tex2Dproj( GrabScreen0, UNITY_PROJ_COORD( ( float4( ( UnpackNormal( tex2D( _DistortionMap, ( _RippleScale * (( ( _Time.y * _RippleSpeed ) + ase_screenPos7 )).xy ) ) ) * _DistortionScale ) , 0.0 ) + ase_screenPos7 ) ) );
			float4 temp_cast_1 = (1.0).xxxx;
			float4 lerpResult3 = lerp( screenColor2 , temp_cast_1 , _Blending);
			o.Emission = lerpResult3.rgb;
			o.Metallic = lerpResult3.r;
			o.Smoothness = lerpResult3.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=12001
0;424;1415;594;545.0989;48.40047;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;17;-1408.898,240.3995;Float;False;Property;_RippleSpeed;RippleSpeed;5;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.TimeNode;11;-1335.5,55.20006;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1111.099,132.3996;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GrabScreenPosition;7;-1321.697,352.5996;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1039.398,242.7996;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1137.299,-81.30045;Float;False;Property;_RippleScale;RippleScale;4;0;0;0;20;0;1;FLOAT
Node;AmplifyShaderEditor.SwizzleNode;12;-926.798,148.0996;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-827.8979,-8.500487;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT2;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;10;-630.7993,137.9998;Float;False;Property;_DistortionScale;DistortionScale;3;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;6;-645.299,-62.40017;Float;True;Property;_DistortionMap;DistortionMap;2;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/SmallWaves.png;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-336.2999,5.199803;Float;False;2;2;0;FLOAT3;0.0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-313.6998,318.6998;Float;False;2;2;0;FLOAT3;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;5;-55.6002,389;Float;False;Property;_Blending;Blending;1;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ScreenColorNode;2;-97.39951,132.9;Float;False;Global;GrabScreen0;Grab Screen 0;0;0;Object;-1;1;0;FLOAT4;0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;4;-54.09977,317.7;Float;False;Constant;_White;White;1;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;3;127.3002,196.2;Float;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.Vector3Node;1;-42.69983,-32.8;Float;False;Constant;_Vector0;Vector 0;0;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;315,-6;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;InvisibleRipples;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0.5;True;True;0;True;Transparent;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;11;2
WireConnection;16;1;17;0
WireConnection;15;0;16;0
WireConnection;15;1;7;0
WireConnection;12;0;15;0
WireConnection;13;0;14;0
WireConnection;13;1;12;0
WireConnection;6;1;13;0
WireConnection;9;0;6;0
WireConnection;9;1;10;0
WireConnection;8;0;9;0
WireConnection;8;1;7;0
WireConnection;2;0;8;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;3;2;5;0
WireConnection;0;0;1;0
WireConnection;0;2;3;0
WireConnection;0;3;3;0
WireConnection;0;4;3;0
ASEEND*/
//CHKSM=17357F3D420133952E05BDB0158A4CFAF525E179