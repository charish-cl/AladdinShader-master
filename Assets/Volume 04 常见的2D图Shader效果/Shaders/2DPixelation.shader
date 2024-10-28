//-----------------------------------------------【Shader说明】--------------------------------------------------------
//     Shader功能：   2D像素风格
//	   核心思路：   对UV进行放大，然后截取整数部分，然后再缩回原大小，UV精度丢失，就形成马赛克效果
//     使用语言：   Shaderlab
//---------------------------------------------------------------------------------------------------------------------

Shader "阿拉丁Shader编程/4-5.2D像素风格" {
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_PixelSize("Pixel Size", Range(1,256)) = 64
	}
		SubShader
		{
			Tags { "Queue" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;
				float _PixelSize;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 col;

					float ratioX = (int)(i.uv.x * _PixelSize) / _PixelSize;
					float ratioY = (int)(i.uv.y * _PixelSize) / _PixelSize;

					col = tex2D(_MainTex, float2(ratioX, ratioY));

					if (col.a < 0.5)
					{
						col.a = 0;
					}

					return col;
				}
				ENDCG
			}
		}
}
