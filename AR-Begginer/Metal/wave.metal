//
//  wave.metal
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/24.
//

#include <metal_stdlib>
using namespace metal;

[[visible]]
void waveMotion(realitykit::geometry_parameters params)
{
    float xSpeed = 1;
    float zSpeed = 1.1;
    float xAmp = 0.01;
    float zAmp = 0.02;

    float3 localPos = params.geometry().model_position();

    float xPeriod = (sin(localPos.x * 40 + params.uniforms().time() /40) + 3) * 2;
    float zPeriod = (sin(localPos.z * 20 + params.uniforms().time() /13) + 3);

    float xOffset = xAmp * sin(xSpeed * params.uniforms().time() + xPeriod * localPos.x);
    float zOffset = zAmp * sin(zSpeed * params.uniforms().time() + zPeriod * localPos.z);
    params.geometry().set_model_position_offset(
        float3(0, xOffset + zOffset, 0)
    );
}
