// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "AladdinShader/06 Diffuse fragment Half Lanbote Shader"
{
    Properties
    {
           _LightColor ("Light Color", Color) = (1, 1, 1, 1)  // 添加光的颜色属性

    }
    SubShader
    {
        Tags
        {
            "RenderType"="ForwardBase"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _LightColor; // 声明光的颜色属性
            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 position : SV_POSITION;
                fixed3 worldNormal : TEXCOORD0;
            };

           

            v2f vert(a2v v)
            {
                v2f o;
                o.position = UnityObjectToClipPos(v.vertex);

                //漫反射
                fixed3 normalDir = normalize(mul(v.normal, (float3x3)unity_ObjectToWorld)); //从模型空间转到世界空间 float3x3 将一个4*4的矩阵强转成3*3的矩阵

                o.worldNormal = normalDir; // 输出世界空间法线
                
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
               fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;//获得系统内置的环境光

                fixed3 lightDir = _WorldSpaceLightPos0.xyz; //对于每一个点来说每一个光的位置就是光的方向（针对平行光）
                fixed3 diffuse = _LightColor.rgb * ( dot(i.worldNormal, lightDir)*0.5 + 0.5);

                return fixed4( diffuse + ambient, 1);
            }
               
            ENDCG
        }
    }
    Fallback "Diffuse"
}