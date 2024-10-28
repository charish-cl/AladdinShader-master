
//-----------------------------------------------【Shader说明】----------------------------------------------
//     Shader功能：   波光粼粼的鱼
//     使用语言：   Shaderlab
//---------------------------------------------------------------------------------------------------------------------


Shader "阿拉丁Shader编程/2-1.波光粼粼的鱼"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_SubTex("SubTex",2D) = "white"{}
		_Color("Color",Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags{"RenderType"="Opaque"}
        LOD 100
        Pass 
		{
            CGPROGRAM
            #pragma vertex vert 
            #pragma fragment frag 

			sampler2D _MainTex;
			sampler2D _SubTex;
			float4 _Color;

            struct a2v{
                fixed4 vertex:POSITION;
                fixed2 uv:TEXCOORD0;
            };

            struct v2f{
                fixed4 svPos:SV_POSITION;
				float2 uv:TEXCOORD0;
            };

            v2f vert(a2v v)
            {
                v2f f;
                f.uv = v.uv;
                f.svPos = UnityObjectToClipPos(v.vertex);
                return f;
            }
            fixed4 frag(v2f f):SV_Target
            {
                float2 offset = float2(0,0);
				offset.x = _Time.y * 0.3f;
                fixed4 col = tex2D(_MainTex, f.uv);
				fixed subCol = tex2D(_SubTex, f.uv+ offset);
				return (subCol + col) * _Color;
            }
            ENDCG
        }
    }
	FallBack  "Specular"
}
