; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=amdgcn -mcpu=gfx900 -mattr=-flat-for-global < %s | FileCheck -enable-var-scope --check-prefix=GFX9 %s
; RUN: llc -mtriple=amdgcn -mcpu=tonga -mattr=-flat-for-global < %s | FileCheck -enable-var-scope --check-prefix=VI %s
; RUN: llc -mtriple=amdgcn -mcpu=bonaire < %s | FileCheck -enable-var-scope --check-prefix=CI %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1010 -mattr=-flat-for-global < %s | FileCheck -enable-var-scope --check-prefix=GFX10 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1100 -mattr=-flat-for-global < %s | FileCheck -enable-var-scope --check-prefix=GFX11 %s

define amdgpu_kernel void @s_ashr_v2i16(ptr addrspace(1) %out, i32, <2 x i16> %lhs, i32, <2 x i16> %rhs) #0 {
; GFX9-LABEL: s_ashr_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s6, s[4:5], 0x30
; GFX9-NEXT:    s_load_dword s7, s[4:5], 0x38
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, s6
; GFX9-NEXT:    v_pk_ashrrev_i16 v0, s7, v0
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: s_ashr_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s6, s[4:5], 0x38
; VI-NEXT:    s_load_dword s7, s[4:5], 0x30
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s4, s6, 16
; VI-NEXT:    s_ashr_i32 s5, s7, 16
; VI-NEXT:    s_ashr_i32 s4, s5, s4
; VI-NEXT:    s_sext_i32_i16 s5, s7
; VI-NEXT:    s_ashr_i32 s5, s5, s6
; VI-NEXT:    s_lshl_b32 s4, s4, 16
; VI-NEXT:    s_and_b32 s5, s5, 0xffff
; VI-NEXT:    s_or_b32 s4, s5, s4
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
;
; CI-LABEL: s_ashr_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s6, s[4:5], 0xc
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x9
; CI-NEXT:    s_load_dword s4, s[4:5], 0xe
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, -1
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_ashr_i32 s5, s6, 16
; CI-NEXT:    s_sext_i32_i16 s6, s6
; CI-NEXT:    s_lshr_b32 s7, s4, 16
; CI-NEXT:    s_ashr_i32 s5, s5, s7
; CI-NEXT:    s_ashr_i32 s4, s6, s4
; CI-NEXT:    s_lshl_b32 s5, s5, 16
; CI-NEXT:    s_and_b32 s4, s4, 0xffff
; CI-NEXT:    s_or_b32 s4, s4, s5
; CI-NEXT:    v_mov_b32_e32 v0, s4
; CI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: s_ashr_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_clause 0x2
; GFX10-NEXT:    s_load_dword s2, s[4:5], 0x30
; GFX10-NEXT:    s_load_dword s3, s[4:5], 0x38
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v0, s3, s2
; GFX10-NEXT:    s_mov_b32 s3, 0x31016000
; GFX10-NEXT:    s_mov_b32 s2, -1
; GFX10-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: s_ashr_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x2
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x30
; GFX11-NEXT:    s_load_b32 s3, s[4:5], 0x38
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x24
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v0, s3, s2
; GFX11-NEXT:    s_mov_b32 s3, 0x31016000
; GFX11-NEXT:    s_mov_b32 s2, -1
; GFX11-NEXT:    buffer_store_b32 v0, off, s[0:3], 0
; GFX11-NEXT:    s_endpgm
  %result = ashr <2 x i16> %lhs, %rhs
  store <2 x i16> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @v_ashr_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; GFX9-LABEL: v_ashr_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v0, v1, v0
; GFX9-NEXT:    global_store_dword v2, v0, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_ashr_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_e32 v4, v1, v0
; VI-NEXT:    v_ashrrev_i16_sdwa v0, v1, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v0, v4, v0
; VI-NEXT:    flat_store_dword v[2:3], v0
; VI-NEXT:    s_endpgm
;
; CI-LABEL: v_ashr_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    buffer_load_dwordx2 v[2:3], v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_bfe_i32 v4, v2, 0, 16
; CI-NEXT:    v_ashrrev_i32_e32 v2, 16, v2
; CI-NEXT:    v_lshrrev_b32_e32 v5, 16, v3
; CI-NEXT:    v_ashrrev_i32_e32 v2, v5, v2
; CI-NEXT:    v_ashrrev_i32_e32 v3, v3, v4
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_and_b32_e32 v3, 0xffff, v3
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: v_ashr_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v0, v1, v0
; GFX10-NEXT:    global_store_dword v2, v0, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_ashr_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b64 v[0:1], v2, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v0, v1, v0
; GFX11-NEXT:    global_store_b32 v2, v0, s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %b_ptr = getelementptr <2 x i16>, ptr addrspace(1) %in.gep, i32 1
  %a = load <2 x i16>, ptr addrspace(1) %in.gep
  %b = load <2 x i16>, ptr addrspace(1) %b_ptr
  %result = ashr <2 x i16> %a, %b
  store <2 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

define amdgpu_kernel void @ashr_v_s_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in, <2 x i16> %sgpr) #0 {
; GFX9-LABEL: ashr_v_s_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    s_load_dword s6, s[4:5], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v1, s6, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v_s_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    s_load_dword s4, s[4:5], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    s_lshr_b32 s1, s4, 16
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_mov_b32_e32 v2, s1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_e32 v4, s4, v3
; VI-NEXT:    v_ashrrev_i16_sdwa v2, v2, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v2, v4, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: ashr_v_s_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_load_dword s8, s[4:5], 0xd
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_lshr_b32 s4, s8, 16
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_bfe_i32 v3, v2, 0, 16
; CI-NEXT:    v_ashrrev_i32_e32 v2, 16, v2
; CI-NEXT:    v_ashrrev_i32_e32 v2, s4, v2
; CI-NEXT:    v_ashrrev_i32_e32 v3, s8, v3
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_and_b32_e32 v3, 0xffff, v3
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: ashr_v_s_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x34
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v1, s4, v1
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ashr_v_s_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_load_b32 s4, s[4:5], 0x34
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v1, s4, v1
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %vgpr = load <2 x i16>, ptr addrspace(1) %in.gep
  %result = ashr <2 x i16> %vgpr, %sgpr
  store <2 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

define amdgpu_kernel void @ashr_s_v_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in, <2 x i16> %sgpr) #0 {
; GFX9-LABEL: ashr_s_v_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    s_load_dword s6, s[4:5], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v1, v1, s6
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: ashr_s_v_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    s_load_dword s4, s[4:5], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    s_lshr_b32 s1, s4, 16
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_mov_b32_e32 v2, s1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_e64 v4, v3, s4
; VI-NEXT:    v_ashrrev_i16_sdwa v2, v3, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v2, v4, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: ashr_s_v_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_load_dword s8, s[4:5], 0xd
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_ashr_i32 s4, s8, 16
; CI-NEXT:    s_sext_i32_i16 s5, s8
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v3, 16, v2
; CI-NEXT:    v_ashr_i32_e32 v2, s5, v2
; CI-NEXT:    v_ashr_i32_e32 v3, s4, v3
; CI-NEXT:    v_and_b32_e32 v2, 0xffff, v2
; CI-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; CI-NEXT:    v_or_b32_e32 v2, v2, v3
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: ashr_s_v_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x34
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v1, v1, s4
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ashr_s_v_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_load_b32 s4, s[4:5], 0x34
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v1, v1, s4
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %vgpr = load <2 x i16>, ptr addrspace(1) %in.gep
  %result = ashr <2 x i16> %sgpr, %vgpr
  store <2 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

define amdgpu_kernel void @ashr_imm_v_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; GFX9-LABEL: ashr_imm_v_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v1, v1, -4 op_sel_hi:[1,0]
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: ashr_imm_v_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    v_mov_b32_e32 v4, -4
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_e64 v2, v3, -4
; VI-NEXT:    v_ashrrev_i16_sdwa v3, v3, v4 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v2, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: ashr_imm_v_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v3, 16, v2
; CI-NEXT:    v_ashr_i32_e32 v2, -4, v2
; CI-NEXT:    v_ashr_i32_e32 v3, -4, v3
; CI-NEXT:    v_and_b32_e32 v2, 0xffff, v2
; CI-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; CI-NEXT:    v_or_b32_e32 v2, v2, v3
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: ashr_imm_v_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v1, v1, -4 op_sel_hi:[1,0]
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ashr_imm_v_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v1, v1, -4 op_sel_hi:[1,0]
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %vgpr = load <2 x i16>, ptr addrspace(1) %in.gep
  %result = ashr <2 x i16> <i16 -4, i16 -4>, %vgpr
  store <2 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

define amdgpu_kernel void @ashr_v_imm_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; GFX9-LABEL: ashr_v_imm_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v1, 8, v1 op_sel_hi:[0,1]
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v_imm_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_mov_b32_e32 v2, 8
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_sdwa v2, v2, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_1
; VI-NEXT:    v_or_b32_sdwa v2, sext(v3), v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_1 src1_sel:DWORD
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: ashr_v_imm_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_bfe_i32 v3, v2, 0, 16
; CI-NEXT:    v_ashrrev_i32_e32 v2, 24, v2
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_bfe_u32 v3, v3, 8, 16
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: ashr_v_imm_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v1, 8, v1 op_sel_hi:[0,1]
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ashr_v_imm_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v1, 8, v1 op_sel_hi:[0,1]
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %vgpr = load <2 x i16>, ptr addrspace(1) %in.gep
  %result = ashr <2 x i16> %vgpr, <i16 8, i16 8>
  store <2 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

define amdgpu_kernel void @v_ashr_v4i16(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; GFX9-LABEL: v_ashr_v4i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx4 v[0:3], v4, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v1, v3, v1
; GFX9-NEXT:    v_pk_ashrrev_i16 v0, v2, v0
; GFX9-NEXT:    global_store_dwordx2 v4, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_ashr_v4i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    v_add_u32_e32 v4, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_e32 v6, v3, v1
; VI-NEXT:    v_ashrrev_i16_sdwa v1, v3, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_ashrrev_i16_e32 v3, v2, v0
; VI-NEXT:    v_ashrrev_i16_sdwa v0, v2, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v1, v6, v1
; VI-NEXT:    v_or_b32_e32 v0, v3, v0
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
;
; CI-LABEL: v_ashr_v4i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; CI-NEXT:    v_mov_b32_e32 v5, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    buffer_load_dwordx4 v[0:3], v[4:5], s[4:7], 0 addr64
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_bfe_i32 v6, v0, 0, 16
; CI-NEXT:    v_ashrrev_i32_e32 v0, 16, v0
; CI-NEXT:    v_bfe_i32 v7, v1, 0, 16
; CI-NEXT:    v_ashrrev_i32_e32 v1, 16, v1
; CI-NEXT:    v_lshrrev_b32_e32 v8, 16, v2
; CI-NEXT:    v_lshrrev_b32_e32 v9, 16, v3
; CI-NEXT:    v_ashrrev_i32_e32 v1, v9, v1
; CI-NEXT:    v_ashrrev_i32_e32 v3, v3, v7
; CI-NEXT:    v_ashrrev_i32_e32 v0, v8, v0
; CI-NEXT:    v_ashrrev_i32_e32 v2, v2, v6
; CI-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; CI-NEXT:    v_and_b32_e32 v3, 0xffff, v3
; CI-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; CI-NEXT:    v_and_b32_e32 v2, 0xffff, v2
; CI-NEXT:    v_or_b32_e32 v1, v3, v1
; CI-NEXT:    v_or_b32_e32 v0, v2, v0
; CI-NEXT:    buffer_store_dwordx2 v[0:1], v[4:5], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: v_ashr_v4i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dwordx4 v[0:3], v4, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v1, v3, v1
; GFX10-NEXT:    v_pk_ashrrev_i16 v0, v2, v0
; GFX10-NEXT:    global_store_dwordx2 v4, v[0:1], s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_ashr_v4i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b128 v[0:3], v4, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v1, v3, v1
; GFX11-NEXT:    v_pk_ashrrev_i16 v0, v2, v0
; GFX11-NEXT:    global_store_b64 v4, v[0:1], s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <4 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <4 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %b_ptr = getelementptr <4 x i16>, ptr addrspace(1) %in.gep, i32 1
  %a = load <4 x i16>, ptr addrspace(1) %in.gep
  %b = load <4 x i16>, ptr addrspace(1) %b_ptr
  %result = ashr <4 x i16> %a, %b
  store <4 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

define amdgpu_kernel void @ashr_v_imm_v4i16(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; GFX9-LABEL: ashr_v_imm_v4i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_ashrrev_i16 v1, 8, v1 op_sel_hi:[0,1]
; GFX9-NEXT:    v_pk_ashrrev_i16 v0, 8, v0 op_sel_hi:[0,1]
; GFX9-NEXT:    global_store_dwordx2 v2, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v_imm_v4i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; VI-NEXT:    v_mov_b32_e32 v4, 8
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i16_sdwa v5, v4, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_1
; VI-NEXT:    v_ashrrev_i16_sdwa v4, v4, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_1
; VI-NEXT:    v_or_b32_sdwa v1, sext(v1), v5 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_sdwa v0, sext(v0), v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_1 src1_sel:DWORD
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
;
; CI-LABEL: ashr_v_imm_v4i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x9
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; CI-NEXT:    buffer_load_dwordx2 v[2:3], v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_bfe_i32 v4, v2, 0, 16
; CI-NEXT:    v_bfe_i32 v5, v3, 0, 16
; CI-NEXT:    v_ashrrev_i32_e32 v3, 24, v3
; CI-NEXT:    v_ashrrev_i32_e32 v2, 24, v2
; CI-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; CI-NEXT:    v_bfe_u32 v5, v5, 8, 16
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_bfe_u32 v4, v4, 8, 16
; CI-NEXT:    v_or_b32_e32 v3, v5, v3
; CI-NEXT:    v_or_b32_e32 v2, v4, v2
; CI-NEXT:    buffer_store_dwordx2 v[2:3], v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: ashr_v_imm_v4i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_ashrrev_i16 v1, 8, v1 op_sel_hi:[0,1]
; GFX10-NEXT:    v_pk_ashrrev_i16 v0, 8, v0 op_sel_hi:[0,1]
; GFX10-NEXT:    global_store_dwordx2 v2, v[0:1], s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ashr_v_imm_v4i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x24
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b64 v[0:1], v2, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_pk_ashrrev_i16 v1, 8, v1 op_sel_hi:[0,1]
; GFX11-NEXT:    v_pk_ashrrev_i16 v0, 8, v0 op_sel_hi:[0,1]
; GFX11-NEXT:    global_store_b64 v2, v[0:1], s[0:1]
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <4 x i16>, ptr addrspace(1) %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <4 x i16>, ptr addrspace(1) %out, i64 %tid.ext
  %vgpr = load <4 x i16>, ptr addrspace(1) %in.gep
  %result = ashr <4 x i16> %vgpr, <i16 8, i16 8, i16 8, i16 8>
  store <4 x i16> %result, ptr addrspace(1) %out.gep
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
