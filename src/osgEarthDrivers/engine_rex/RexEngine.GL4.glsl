#extension GL_ARB_gpu_shader_int64 : enable

#define OE_USE_GL4
#define OE_TILE_SIZE 17
#define OE_TILE_VERTS 417
#define OE_SKIRT_VERTS 128

struct oe_rex_Shared {
    vec2 morphConstants[19];
    float padding[2];
};
struct oe_rex_Tile {
    vec4 tileKey;
    mat4 modelViewMatrix;
    mat4 colorMat;
    mat4 parentMat;
    mat4 elevMat;
    mat4 normalMat;
    mat4 landcoverMat;
    mat4 sharedMat[8];
    int colorIndex;
    int parentIndex;
    int elevIndex;
    int normalIndex;
    int landcoverIndex;
    int sharedIndex[8];
    int drawOrder;
    float padding[2];
};
layout(binding = 29, std430) readonly buffer RexTextureArena {
    uint64_t oe_terrain_tex[];
};
layout(binding = 30, std430) readonly buffer RexSharedDataBuffer {
    oe_rex_Shared oe_shared;
};
layout(binding = 31, std430) readonly buffer RexTileBuffer {
    oe_rex_Tile oe_tile[];
};

#if defined(VP_STAGE_VERTEX)
flat out int oe_tileID;
#elif defined(VP_STAGE_FRAGMENT)
flat in int oe_tileID;
#else
int oe_tileID;
#endif
