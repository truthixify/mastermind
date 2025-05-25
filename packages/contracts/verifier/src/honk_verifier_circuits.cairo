use core::circuit::{
    CircuitElement as CE, CircuitInput as CI, CircuitInputs, CircuitModulus, CircuitOutputsTrait,
    EvalCircuitTrait, circuit_add, circuit_inverse, circuit_mul, circuit_sub, u384,
};
use garaga::core::circuit::{AddInputResultTrait2, IntoCircuitInputValue, u288IntoCircuitInputValue};
use garaga::definitions::G1Point;
use garaga::ec_ops::FunctionFelt;

#[inline(always)]
pub fn run_GRUMPKIN_HONK_SUMCHECK_SIZE_13_PUB_24_circuit(
    p_public_inputs: Span<u256>,
    p_pairing_point_object: Span<u256>,
    p_public_inputs_offset: u384,
    sumcheck_univariates_flat: Span<u256>,
    sumcheck_evaluations: Span<u256>,
    tp_sum_check_u_challenges: Span<u128>,
    tp_gate_challenges: Span<u128>,
    tp_eta_1: u128,
    tp_eta_2: u128,
    tp_eta_3: u128,
    tp_beta: u128,
    tp_gamma: u128,
    tp_base_rlc: u384,
    tp_alphas: Span<u128>,
    modulus: CircuitModulus,
) -> (u384, u384) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x1
    let in1 = CE::<CI<1>> {}; // 0x2000
    let in2 = CE::<CI<2>> {}; // 0x0
    let in3 = CE::<CI<3>> {}; // 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffec51
    let in4 = CE::<CI<4>> {}; // 0x2d0
    let in5 = CE::<CI<5>> {}; // 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffff11
    let in6 = CE::<CI<6>> {}; // 0x90
    let in7 = CE::<CI<7>> {}; // 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffff71
    let in8 = CE::<CI<8>> {}; // 0xf0
    let in9 = CE::<CI<9>> {}; // 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593effffd31
    let in10 = CE::<CI<10>> {}; // 0x13b0
    let in11 = CE::<CI<11>> {}; // 0x2
    let in12 = CE::<CI<12>> {}; // 0x3
    let in13 = CE::<CI<13>> {}; // 0x4
    let in14 = CE::<CI<14>> {}; // 0x5
    let in15 = CE::<CI<15>> {}; // 0x6
    let in16 = CE::<CI<16>> {}; // 0x7
    let in17 = CE::<
        CI<17>,
    > {}; // 0x183227397098d014dc2822db40c0ac2e9419f4243cdcb848a1f0fac9f8000000
    let in18 = CE::<CI<18>> {}; // -0x1 % p
    let in19 = CE::<CI<19>> {}; // 0x11
    let in20 = CE::<CI<20>> {}; // 0x9
    let in21 = CE::<CI<21>> {}; // 0x100000000000000000
    let in22 = CE::<CI<22>> {}; // 0x4000
    let in23 = CE::<
        CI<23>,
    > {}; // 0x10dc6e9c006ea38b04b1e03b4bd9490c0d03f98929ca1d7fb56821fd19d3b6e7
    let in24 = CE::<CI<24>> {}; // 0xc28145b6a44df3e0149b3d0a30b3bb599df9756d4dd9b84a86b38cfb45a740b
    let in25 = CE::<CI<25>> {}; // 0x544b8338791518b2c7645a50392798b21f75bb60e3596170067d00141cac15
    let in26 = CE::<
        CI<26>,
    > {}; // 0x222c01175718386f2e2e82eb122789e352e105a3b8fa852613bc534433ee428b

    // INPUT stack
    let (in27, in28, in29) = (CE::<CI<27>> {}, CE::<CI<28>> {}, CE::<CI<29>> {});
    let (in30, in31, in32) = (CE::<CI<30>> {}, CE::<CI<31>> {}, CE::<CI<32>> {});
    let (in33, in34, in35) = (CE::<CI<33>> {}, CE::<CI<34>> {}, CE::<CI<35>> {});
    let (in36, in37, in38) = (CE::<CI<36>> {}, CE::<CI<37>> {}, CE::<CI<38>> {});
    let (in39, in40, in41) = (CE::<CI<39>> {}, CE::<CI<40>> {}, CE::<CI<41>> {});
    let (in42, in43, in44) = (CE::<CI<42>> {}, CE::<CI<43>> {}, CE::<CI<44>> {});
    let (in45, in46, in47) = (CE::<CI<45>> {}, CE::<CI<46>> {}, CE::<CI<47>> {});
    let (in48, in49, in50) = (CE::<CI<48>> {}, CE::<CI<49>> {}, CE::<CI<50>> {});
    let (in51, in52, in53) = (CE::<CI<51>> {}, CE::<CI<52>> {}, CE::<CI<53>> {});
    let (in54, in55, in56) = (CE::<CI<54>> {}, CE::<CI<55>> {}, CE::<CI<56>> {});
    let (in57, in58, in59) = (CE::<CI<57>> {}, CE::<CI<58>> {}, CE::<CI<59>> {});
    let (in60, in61, in62) = (CE::<CI<60>> {}, CE::<CI<61>> {}, CE::<CI<62>> {});
    let (in63, in64, in65) = (CE::<CI<63>> {}, CE::<CI<64>> {}, CE::<CI<65>> {});
    let (in66, in67, in68) = (CE::<CI<66>> {}, CE::<CI<67>> {}, CE::<CI<68>> {});
    let (in69, in70, in71) = (CE::<CI<69>> {}, CE::<CI<70>> {}, CE::<CI<71>> {});
    let (in72, in73, in74) = (CE::<CI<72>> {}, CE::<CI<73>> {}, CE::<CI<74>> {});
    let (in75, in76, in77) = (CE::<CI<75>> {}, CE::<CI<76>> {}, CE::<CI<77>> {});
    let (in78, in79, in80) = (CE::<CI<78>> {}, CE::<CI<79>> {}, CE::<CI<80>> {});
    let (in81, in82, in83) = (CE::<CI<81>> {}, CE::<CI<82>> {}, CE::<CI<83>> {});
    let (in84, in85, in86) = (CE::<CI<84>> {}, CE::<CI<85>> {}, CE::<CI<86>> {});
    let (in87, in88, in89) = (CE::<CI<87>> {}, CE::<CI<88>> {}, CE::<CI<89>> {});
    let (in90, in91, in92) = (CE::<CI<90>> {}, CE::<CI<91>> {}, CE::<CI<92>> {});
    let (in93, in94, in95) = (CE::<CI<93>> {}, CE::<CI<94>> {}, CE::<CI<95>> {});
    let (in96, in97, in98) = (CE::<CI<96>> {}, CE::<CI<97>> {}, CE::<CI<98>> {});
    let (in99, in100, in101) = (CE::<CI<99>> {}, CE::<CI<100>> {}, CE::<CI<101>> {});
    let (in102, in103, in104) = (CE::<CI<102>> {}, CE::<CI<103>> {}, CE::<CI<104>> {});
    let (in105, in106, in107) = (CE::<CI<105>> {}, CE::<CI<106>> {}, CE::<CI<107>> {});
    let (in108, in109, in110) = (CE::<CI<108>> {}, CE::<CI<109>> {}, CE::<CI<110>> {});
    let (in111, in112, in113) = (CE::<CI<111>> {}, CE::<CI<112>> {}, CE::<CI<113>> {});
    let (in114, in115, in116) = (CE::<CI<114>> {}, CE::<CI<115>> {}, CE::<CI<116>> {});
    let (in117, in118, in119) = (CE::<CI<117>> {}, CE::<CI<118>> {}, CE::<CI<119>> {});
    let (in120, in121, in122) = (CE::<CI<120>> {}, CE::<CI<121>> {}, CE::<CI<122>> {});
    let (in123, in124, in125) = (CE::<CI<123>> {}, CE::<CI<124>> {}, CE::<CI<125>> {});
    let (in126, in127, in128) = (CE::<CI<126>> {}, CE::<CI<127>> {}, CE::<CI<128>> {});
    let (in129, in130, in131) = (CE::<CI<129>> {}, CE::<CI<130>> {}, CE::<CI<131>> {});
    let (in132, in133, in134) = (CE::<CI<132>> {}, CE::<CI<133>> {}, CE::<CI<134>> {});
    let (in135, in136, in137) = (CE::<CI<135>> {}, CE::<CI<136>> {}, CE::<CI<137>> {});
    let (in138, in139, in140) = (CE::<CI<138>> {}, CE::<CI<139>> {}, CE::<CI<140>> {});
    let (in141, in142, in143) = (CE::<CI<141>> {}, CE::<CI<142>> {}, CE::<CI<143>> {});
    let (in144, in145, in146) = (CE::<CI<144>> {}, CE::<CI<145>> {}, CE::<CI<146>> {});
    let (in147, in148, in149) = (CE::<CI<147>> {}, CE::<CI<148>> {}, CE::<CI<149>> {});
    let (in150, in151, in152) = (CE::<CI<150>> {}, CE::<CI<151>> {}, CE::<CI<152>> {});
    let (in153, in154, in155) = (CE::<CI<153>> {}, CE::<CI<154>> {}, CE::<CI<155>> {});
    let (in156, in157, in158) = (CE::<CI<156>> {}, CE::<CI<157>> {}, CE::<CI<158>> {});
    let (in159, in160, in161) = (CE::<CI<159>> {}, CE::<CI<160>> {}, CE::<CI<161>> {});
    let (in162, in163, in164) = (CE::<CI<162>> {}, CE::<CI<163>> {}, CE::<CI<164>> {});
    let (in165, in166, in167) = (CE::<CI<165>> {}, CE::<CI<166>> {}, CE::<CI<167>> {});
    let (in168, in169, in170) = (CE::<CI<168>> {}, CE::<CI<169>> {}, CE::<CI<170>> {});
    let (in171, in172, in173) = (CE::<CI<171>> {}, CE::<CI<172>> {}, CE::<CI<173>> {});
    let (in174, in175, in176) = (CE::<CI<174>> {}, CE::<CI<175>> {}, CE::<CI<176>> {});
    let (in177, in178, in179) = (CE::<CI<177>> {}, CE::<CI<178>> {}, CE::<CI<179>> {});
    let (in180, in181, in182) = (CE::<CI<180>> {}, CE::<CI<181>> {}, CE::<CI<182>> {});
    let (in183, in184, in185) = (CE::<CI<183>> {}, CE::<CI<184>> {}, CE::<CI<185>> {});
    let (in186, in187, in188) = (CE::<CI<186>> {}, CE::<CI<187>> {}, CE::<CI<188>> {});
    let (in189, in190, in191) = (CE::<CI<189>> {}, CE::<CI<190>> {}, CE::<CI<191>> {});
    let (in192, in193, in194) = (CE::<CI<192>> {}, CE::<CI<193>> {}, CE::<CI<194>> {});
    let (in195, in196, in197) = (CE::<CI<195>> {}, CE::<CI<196>> {}, CE::<CI<197>> {});
    let (in198, in199, in200) = (CE::<CI<198>> {}, CE::<CI<199>> {}, CE::<CI<200>> {});
    let (in201, in202, in203) = (CE::<CI<201>> {}, CE::<CI<202>> {}, CE::<CI<203>> {});
    let (in204, in205, in206) = (CE::<CI<204>> {}, CE::<CI<205>> {}, CE::<CI<206>> {});
    let (in207, in208, in209) = (CE::<CI<207>> {}, CE::<CI<208>> {}, CE::<CI<209>> {});
    let (in210, in211, in212) = (CE::<CI<210>> {}, CE::<CI<211>> {}, CE::<CI<212>> {});
    let (in213, in214, in215) = (CE::<CI<213>> {}, CE::<CI<214>> {}, CE::<CI<215>> {});
    let (in216, in217, in218) = (CE::<CI<216>> {}, CE::<CI<217>> {}, CE::<CI<218>> {});
    let (in219, in220, in221) = (CE::<CI<219>> {}, CE::<CI<220>> {}, CE::<CI<221>> {});
    let (in222, in223, in224) = (CE::<CI<222>> {}, CE::<CI<223>> {}, CE::<CI<224>> {});
    let (in225, in226, in227) = (CE::<CI<225>> {}, CE::<CI<226>> {}, CE::<CI<227>> {});
    let (in228, in229, in230) = (CE::<CI<228>> {}, CE::<CI<229>> {}, CE::<CI<230>> {});
    let (in231, in232, in233) = (CE::<CI<231>> {}, CE::<CI<232>> {}, CE::<CI<233>> {});
    let (in234, in235, in236) = (CE::<CI<234>> {}, CE::<CI<235>> {}, CE::<CI<236>> {});
    let (in237, in238, in239) = (CE::<CI<237>> {}, CE::<CI<238>> {}, CE::<CI<239>> {});
    let (in240, in241, in242) = (CE::<CI<240>> {}, CE::<CI<241>> {}, CE::<CI<242>> {});
    let (in243, in244, in245) = (CE::<CI<243>> {}, CE::<CI<244>> {}, CE::<CI<245>> {});
    let (in246, in247, in248) = (CE::<CI<246>> {}, CE::<CI<247>> {}, CE::<CI<248>> {});
    let (in249, in250, in251) = (CE::<CI<249>> {}, CE::<CI<250>> {}, CE::<CI<251>> {});
    let in252 = CE::<CI<252>> {};
    let t0 = circuit_add(in1, in51);
    let t1 = circuit_mul(in225, t0);
    let t2 = circuit_add(in226, t1);
    let t3 = circuit_add(in51, in0);
    let t4 = circuit_mul(in225, t3);
    let t5 = circuit_sub(in226, t4);
    let t6 = circuit_add(t2, in27);
    let t7 = circuit_mul(in0, t6);
    let t8 = circuit_add(t5, in27);
    let t9 = circuit_mul(in0, t8);
    let t10 = circuit_add(t2, in225);
    let t11 = circuit_sub(t5, in225);
    let t12 = circuit_add(t10, in28);
    let t13 = circuit_mul(t7, t12);
    let t14 = circuit_add(t11, in28);
    let t15 = circuit_mul(t9, t14);
    let t16 = circuit_add(t10, in225);
    let t17 = circuit_sub(t11, in225);
    let t18 = circuit_add(t16, in29);
    let t19 = circuit_mul(t13, t18);
    let t20 = circuit_add(t17, in29);
    let t21 = circuit_mul(t15, t20);
    let t22 = circuit_add(t16, in225);
    let t23 = circuit_sub(t17, in225);
    let t24 = circuit_add(t22, in30);
    let t25 = circuit_mul(t19, t24);
    let t26 = circuit_add(t23, in30);
    let t27 = circuit_mul(t21, t26);
    let t28 = circuit_add(t22, in225);
    let t29 = circuit_sub(t23, in225);
    let t30 = circuit_add(t28, in31);
    let t31 = circuit_mul(t25, t30);
    let t32 = circuit_add(t29, in31);
    let t33 = circuit_mul(t27, t32);
    let t34 = circuit_add(t28, in225);
    let t35 = circuit_sub(t29, in225);
    let t36 = circuit_add(t34, in32);
    let t37 = circuit_mul(t31, t36);
    let t38 = circuit_add(t35, in32);
    let t39 = circuit_mul(t33, t38);
    let t40 = circuit_add(t34, in225);
    let t41 = circuit_sub(t35, in225);
    let t42 = circuit_add(t40, in33);
    let t43 = circuit_mul(t37, t42);
    let t44 = circuit_add(t41, in33);
    let t45 = circuit_mul(t39, t44);
    let t46 = circuit_add(t40, in225);
    let t47 = circuit_sub(t41, in225);
    let t48 = circuit_add(t46, in34);
    let t49 = circuit_mul(t43, t48);
    let t50 = circuit_add(t47, in34);
    let t51 = circuit_mul(t45, t50);
    let t52 = circuit_add(t46, in225);
    let t53 = circuit_sub(t47, in225);
    let t54 = circuit_add(t52, in35);
    let t55 = circuit_mul(t49, t54);
    let t56 = circuit_add(t53, in35);
    let t57 = circuit_mul(t51, t56);
    let t58 = circuit_add(t52, in225);
    let t59 = circuit_sub(t53, in225);
    let t60 = circuit_add(t58, in36);
    let t61 = circuit_mul(t55, t60);
    let t62 = circuit_add(t59, in36);
    let t63 = circuit_mul(t57, t62);
    let t64 = circuit_add(t58, in225);
    let t65 = circuit_sub(t59, in225);
    let t66 = circuit_add(t64, in37);
    let t67 = circuit_mul(t61, t66);
    let t68 = circuit_add(t65, in37);
    let t69 = circuit_mul(t63, t68);
    let t70 = circuit_add(t64, in225);
    let t71 = circuit_sub(t65, in225);
    let t72 = circuit_add(t70, in38);
    let t73 = circuit_mul(t67, t72);
    let t74 = circuit_add(t71, in38);
    let t75 = circuit_mul(t69, t74);
    let t76 = circuit_add(t70, in225);
    let t77 = circuit_sub(t71, in225);
    let t78 = circuit_add(t76, in39);
    let t79 = circuit_mul(t73, t78);
    let t80 = circuit_add(t77, in39);
    let t81 = circuit_mul(t75, t80);
    let t82 = circuit_add(t76, in225);
    let t83 = circuit_sub(t77, in225);
    let t84 = circuit_add(t82, in40);
    let t85 = circuit_mul(t79, t84);
    let t86 = circuit_add(t83, in40);
    let t87 = circuit_mul(t81, t86);
    let t88 = circuit_add(t82, in225);
    let t89 = circuit_sub(t83, in225);
    let t90 = circuit_add(t88, in41);
    let t91 = circuit_mul(t85, t90);
    let t92 = circuit_add(t89, in41);
    let t93 = circuit_mul(t87, t92);
    let t94 = circuit_add(t88, in225);
    let t95 = circuit_sub(t89, in225);
    let t96 = circuit_add(t94, in42);
    let t97 = circuit_mul(t91, t96);
    let t98 = circuit_add(t95, in42);
    let t99 = circuit_mul(t93, t98);
    let t100 = circuit_add(t94, in225);
    let t101 = circuit_sub(t95, in225);
    let t102 = circuit_add(t100, in43);
    let t103 = circuit_mul(t97, t102);
    let t104 = circuit_add(t101, in43);
    let t105 = circuit_mul(t99, t104);
    let t106 = circuit_add(t100, in225);
    let t107 = circuit_sub(t101, in225);
    let t108 = circuit_add(t106, in44);
    let t109 = circuit_mul(t103, t108);
    let t110 = circuit_add(t107, in44);
    let t111 = circuit_mul(t105, t110);
    let t112 = circuit_add(t106, in225);
    let t113 = circuit_sub(t107, in225);
    let t114 = circuit_add(t112, in45);
    let t115 = circuit_mul(t109, t114);
    let t116 = circuit_add(t113, in45);
    let t117 = circuit_mul(t111, t116);
    let t118 = circuit_add(t112, in225);
    let t119 = circuit_sub(t113, in225);
    let t120 = circuit_add(t118, in46);
    let t121 = circuit_mul(t115, t120);
    let t122 = circuit_add(t119, in46);
    let t123 = circuit_mul(t117, t122);
    let t124 = circuit_add(t118, in225);
    let t125 = circuit_sub(t119, in225);
    let t126 = circuit_add(t124, in47);
    let t127 = circuit_mul(t121, t126);
    let t128 = circuit_add(t125, in47);
    let t129 = circuit_mul(t123, t128);
    let t130 = circuit_add(t124, in225);
    let t131 = circuit_sub(t125, in225);
    let t132 = circuit_add(t130, in48);
    let t133 = circuit_mul(t127, t132);
    let t134 = circuit_add(t131, in48);
    let t135 = circuit_mul(t129, t134);
    let t136 = circuit_add(t130, in225);
    let t137 = circuit_sub(t131, in225);
    let t138 = circuit_add(t136, in49);
    let t139 = circuit_mul(t133, t138);
    let t140 = circuit_add(t137, in49);
    let t141 = circuit_mul(t135, t140);
    let t142 = circuit_add(t136, in225);
    let t143 = circuit_sub(t137, in225);
    let t144 = circuit_add(t142, in50);
    let t145 = circuit_mul(t139, t144);
    let t146 = circuit_add(t143, in50);
    let t147 = circuit_mul(t141, t146);
    let t148 = circuit_inverse(t147);
    let t149 = circuit_mul(t145, t148);
    let t150 = circuit_add(in52, in53);
    let t151 = circuit_sub(t150, in2);
    let t152 = circuit_mul(t151, in227);
    let t153 = circuit_mul(in227, in227);
    let t154 = circuit_sub(in196, in2);
    let t155 = circuit_mul(in0, t154);
    let t156 = circuit_sub(in196, in2);
    let t157 = circuit_mul(in3, t156);
    let t158 = circuit_inverse(t157);
    let t159 = circuit_mul(in52, t158);
    let t160 = circuit_add(in2, t159);
    let t161 = circuit_sub(in196, in0);
    let t162 = circuit_mul(t155, t161);
    let t163 = circuit_sub(in196, in0);
    let t164 = circuit_mul(in4, t163);
    let t165 = circuit_inverse(t164);
    let t166 = circuit_mul(in53, t165);
    let t167 = circuit_add(t160, t166);
    let t168 = circuit_sub(in196, in11);
    let t169 = circuit_mul(t162, t168);
    let t170 = circuit_sub(in196, in11);
    let t171 = circuit_mul(in5, t170);
    let t172 = circuit_inverse(t171);
    let t173 = circuit_mul(in54, t172);
    let t174 = circuit_add(t167, t173);
    let t175 = circuit_sub(in196, in12);
    let t176 = circuit_mul(t169, t175);
    let t177 = circuit_sub(in196, in12);
    let t178 = circuit_mul(in6, t177);
    let t179 = circuit_inverse(t178);
    let t180 = circuit_mul(in55, t179);
    let t181 = circuit_add(t174, t180);
    let t182 = circuit_sub(in196, in13);
    let t183 = circuit_mul(t176, t182);
    let t184 = circuit_sub(in196, in13);
    let t185 = circuit_mul(in7, t184);
    let t186 = circuit_inverse(t185);
    let t187 = circuit_mul(in56, t186);
    let t188 = circuit_add(t181, t187);
    let t189 = circuit_sub(in196, in14);
    let t190 = circuit_mul(t183, t189);
    let t191 = circuit_sub(in196, in14);
    let t192 = circuit_mul(in8, t191);
    let t193 = circuit_inverse(t192);
    let t194 = circuit_mul(in57, t193);
    let t195 = circuit_add(t188, t194);
    let t196 = circuit_sub(in196, in15);
    let t197 = circuit_mul(t190, t196);
    let t198 = circuit_sub(in196, in15);
    let t199 = circuit_mul(in9, t198);
    let t200 = circuit_inverse(t199);
    let t201 = circuit_mul(in58, t200);
    let t202 = circuit_add(t195, t201);
    let t203 = circuit_sub(in196, in16);
    let t204 = circuit_mul(t197, t203);
    let t205 = circuit_sub(in196, in16);
    let t206 = circuit_mul(in10, t205);
    let t207 = circuit_inverse(t206);
    let t208 = circuit_mul(in59, t207);
    let t209 = circuit_add(t202, t208);
    let t210 = circuit_mul(t209, t204);
    let t211 = circuit_sub(in209, in0);
    let t212 = circuit_mul(in196, t211);
    let t213 = circuit_add(in0, t212);
    let t214 = circuit_mul(in0, t213);
    let t215 = circuit_add(in60, in61);
    let t216 = circuit_sub(t215, t210);
    let t217 = circuit_mul(t216, t153);
    let t218 = circuit_add(t152, t217);
    let t219 = circuit_mul(t153, in227);
    let t220 = circuit_sub(in197, in2);
    let t221 = circuit_mul(in0, t220);
    let t222 = circuit_sub(in197, in2);
    let t223 = circuit_mul(in3, t222);
    let t224 = circuit_inverse(t223);
    let t225 = circuit_mul(in60, t224);
    let t226 = circuit_add(in2, t225);
    let t227 = circuit_sub(in197, in0);
    let t228 = circuit_mul(t221, t227);
    let t229 = circuit_sub(in197, in0);
    let t230 = circuit_mul(in4, t229);
    let t231 = circuit_inverse(t230);
    let t232 = circuit_mul(in61, t231);
    let t233 = circuit_add(t226, t232);
    let t234 = circuit_sub(in197, in11);
    let t235 = circuit_mul(t228, t234);
    let t236 = circuit_sub(in197, in11);
    let t237 = circuit_mul(in5, t236);
    let t238 = circuit_inverse(t237);
    let t239 = circuit_mul(in62, t238);
    let t240 = circuit_add(t233, t239);
    let t241 = circuit_sub(in197, in12);
    let t242 = circuit_mul(t235, t241);
    let t243 = circuit_sub(in197, in12);
    let t244 = circuit_mul(in6, t243);
    let t245 = circuit_inverse(t244);
    let t246 = circuit_mul(in63, t245);
    let t247 = circuit_add(t240, t246);
    let t248 = circuit_sub(in197, in13);
    let t249 = circuit_mul(t242, t248);
    let t250 = circuit_sub(in197, in13);
    let t251 = circuit_mul(in7, t250);
    let t252 = circuit_inverse(t251);
    let t253 = circuit_mul(in64, t252);
    let t254 = circuit_add(t247, t253);
    let t255 = circuit_sub(in197, in14);
    let t256 = circuit_mul(t249, t255);
    let t257 = circuit_sub(in197, in14);
    let t258 = circuit_mul(in8, t257);
    let t259 = circuit_inverse(t258);
    let t260 = circuit_mul(in65, t259);
    let t261 = circuit_add(t254, t260);
    let t262 = circuit_sub(in197, in15);
    let t263 = circuit_mul(t256, t262);
    let t264 = circuit_sub(in197, in15);
    let t265 = circuit_mul(in9, t264);
    let t266 = circuit_inverse(t265);
    let t267 = circuit_mul(in66, t266);
    let t268 = circuit_add(t261, t267);
    let t269 = circuit_sub(in197, in16);
    let t270 = circuit_mul(t263, t269);
    let t271 = circuit_sub(in197, in16);
    let t272 = circuit_mul(in10, t271);
    let t273 = circuit_inverse(t272);
    let t274 = circuit_mul(in67, t273);
    let t275 = circuit_add(t268, t274);
    let t276 = circuit_mul(t275, t270);
    let t277 = circuit_sub(in210, in0);
    let t278 = circuit_mul(in197, t277);
    let t279 = circuit_add(in0, t278);
    let t280 = circuit_mul(t214, t279);
    let t281 = circuit_add(in68, in69);
    let t282 = circuit_sub(t281, t276);
    let t283 = circuit_mul(t282, t219);
    let t284 = circuit_add(t218, t283);
    let t285 = circuit_mul(t219, in227);
    let t286 = circuit_sub(in198, in2);
    let t287 = circuit_mul(in0, t286);
    let t288 = circuit_sub(in198, in2);
    let t289 = circuit_mul(in3, t288);
    let t290 = circuit_inverse(t289);
    let t291 = circuit_mul(in68, t290);
    let t292 = circuit_add(in2, t291);
    let t293 = circuit_sub(in198, in0);
    let t294 = circuit_mul(t287, t293);
    let t295 = circuit_sub(in198, in0);
    let t296 = circuit_mul(in4, t295);
    let t297 = circuit_inverse(t296);
    let t298 = circuit_mul(in69, t297);
    let t299 = circuit_add(t292, t298);
    let t300 = circuit_sub(in198, in11);
    let t301 = circuit_mul(t294, t300);
    let t302 = circuit_sub(in198, in11);
    let t303 = circuit_mul(in5, t302);
    let t304 = circuit_inverse(t303);
    let t305 = circuit_mul(in70, t304);
    let t306 = circuit_add(t299, t305);
    let t307 = circuit_sub(in198, in12);
    let t308 = circuit_mul(t301, t307);
    let t309 = circuit_sub(in198, in12);
    let t310 = circuit_mul(in6, t309);
    let t311 = circuit_inverse(t310);
    let t312 = circuit_mul(in71, t311);
    let t313 = circuit_add(t306, t312);
    let t314 = circuit_sub(in198, in13);
    let t315 = circuit_mul(t308, t314);
    let t316 = circuit_sub(in198, in13);
    let t317 = circuit_mul(in7, t316);
    let t318 = circuit_inverse(t317);
    let t319 = circuit_mul(in72, t318);
    let t320 = circuit_add(t313, t319);
    let t321 = circuit_sub(in198, in14);
    let t322 = circuit_mul(t315, t321);
    let t323 = circuit_sub(in198, in14);
    let t324 = circuit_mul(in8, t323);
    let t325 = circuit_inverse(t324);
    let t326 = circuit_mul(in73, t325);
    let t327 = circuit_add(t320, t326);
    let t328 = circuit_sub(in198, in15);
    let t329 = circuit_mul(t322, t328);
    let t330 = circuit_sub(in198, in15);
    let t331 = circuit_mul(in9, t330);
    let t332 = circuit_inverse(t331);
    let t333 = circuit_mul(in74, t332);
    let t334 = circuit_add(t327, t333);
    let t335 = circuit_sub(in198, in16);
    let t336 = circuit_mul(t329, t335);
    let t337 = circuit_sub(in198, in16);
    let t338 = circuit_mul(in10, t337);
    let t339 = circuit_inverse(t338);
    let t340 = circuit_mul(in75, t339);
    let t341 = circuit_add(t334, t340);
    let t342 = circuit_mul(t341, t336);
    let t343 = circuit_sub(in211, in0);
    let t344 = circuit_mul(in198, t343);
    let t345 = circuit_add(in0, t344);
    let t346 = circuit_mul(t280, t345);
    let t347 = circuit_add(in76, in77);
    let t348 = circuit_sub(t347, t342);
    let t349 = circuit_mul(t348, t285);
    let t350 = circuit_add(t284, t349);
    let t351 = circuit_mul(t285, in227);
    let t352 = circuit_sub(in199, in2);
    let t353 = circuit_mul(in0, t352);
    let t354 = circuit_sub(in199, in2);
    let t355 = circuit_mul(in3, t354);
    let t356 = circuit_inverse(t355);
    let t357 = circuit_mul(in76, t356);
    let t358 = circuit_add(in2, t357);
    let t359 = circuit_sub(in199, in0);
    let t360 = circuit_mul(t353, t359);
    let t361 = circuit_sub(in199, in0);
    let t362 = circuit_mul(in4, t361);
    let t363 = circuit_inverse(t362);
    let t364 = circuit_mul(in77, t363);
    let t365 = circuit_add(t358, t364);
    let t366 = circuit_sub(in199, in11);
    let t367 = circuit_mul(t360, t366);
    let t368 = circuit_sub(in199, in11);
    let t369 = circuit_mul(in5, t368);
    let t370 = circuit_inverse(t369);
    let t371 = circuit_mul(in78, t370);
    let t372 = circuit_add(t365, t371);
    let t373 = circuit_sub(in199, in12);
    let t374 = circuit_mul(t367, t373);
    let t375 = circuit_sub(in199, in12);
    let t376 = circuit_mul(in6, t375);
    let t377 = circuit_inverse(t376);
    let t378 = circuit_mul(in79, t377);
    let t379 = circuit_add(t372, t378);
    let t380 = circuit_sub(in199, in13);
    let t381 = circuit_mul(t374, t380);
    let t382 = circuit_sub(in199, in13);
    let t383 = circuit_mul(in7, t382);
    let t384 = circuit_inverse(t383);
    let t385 = circuit_mul(in80, t384);
    let t386 = circuit_add(t379, t385);
    let t387 = circuit_sub(in199, in14);
    let t388 = circuit_mul(t381, t387);
    let t389 = circuit_sub(in199, in14);
    let t390 = circuit_mul(in8, t389);
    let t391 = circuit_inverse(t390);
    let t392 = circuit_mul(in81, t391);
    let t393 = circuit_add(t386, t392);
    let t394 = circuit_sub(in199, in15);
    let t395 = circuit_mul(t388, t394);
    let t396 = circuit_sub(in199, in15);
    let t397 = circuit_mul(in9, t396);
    let t398 = circuit_inverse(t397);
    let t399 = circuit_mul(in82, t398);
    let t400 = circuit_add(t393, t399);
    let t401 = circuit_sub(in199, in16);
    let t402 = circuit_mul(t395, t401);
    let t403 = circuit_sub(in199, in16);
    let t404 = circuit_mul(in10, t403);
    let t405 = circuit_inverse(t404);
    let t406 = circuit_mul(in83, t405);
    let t407 = circuit_add(t400, t406);
    let t408 = circuit_mul(t407, t402);
    let t409 = circuit_sub(in212, in0);
    let t410 = circuit_mul(in199, t409);
    let t411 = circuit_add(in0, t410);
    let t412 = circuit_mul(t346, t411);
    let t413 = circuit_add(in84, in85);
    let t414 = circuit_sub(t413, t408);
    let t415 = circuit_mul(t414, t351);
    let t416 = circuit_add(t350, t415);
    let t417 = circuit_mul(t351, in227);
    let t418 = circuit_sub(in200, in2);
    let t419 = circuit_mul(in0, t418);
    let t420 = circuit_sub(in200, in2);
    let t421 = circuit_mul(in3, t420);
    let t422 = circuit_inverse(t421);
    let t423 = circuit_mul(in84, t422);
    let t424 = circuit_add(in2, t423);
    let t425 = circuit_sub(in200, in0);
    let t426 = circuit_mul(t419, t425);
    let t427 = circuit_sub(in200, in0);
    let t428 = circuit_mul(in4, t427);
    let t429 = circuit_inverse(t428);
    let t430 = circuit_mul(in85, t429);
    let t431 = circuit_add(t424, t430);
    let t432 = circuit_sub(in200, in11);
    let t433 = circuit_mul(t426, t432);
    let t434 = circuit_sub(in200, in11);
    let t435 = circuit_mul(in5, t434);
    let t436 = circuit_inverse(t435);
    let t437 = circuit_mul(in86, t436);
    let t438 = circuit_add(t431, t437);
    let t439 = circuit_sub(in200, in12);
    let t440 = circuit_mul(t433, t439);
    let t441 = circuit_sub(in200, in12);
    let t442 = circuit_mul(in6, t441);
    let t443 = circuit_inverse(t442);
    let t444 = circuit_mul(in87, t443);
    let t445 = circuit_add(t438, t444);
    let t446 = circuit_sub(in200, in13);
    let t447 = circuit_mul(t440, t446);
    let t448 = circuit_sub(in200, in13);
    let t449 = circuit_mul(in7, t448);
    let t450 = circuit_inverse(t449);
    let t451 = circuit_mul(in88, t450);
    let t452 = circuit_add(t445, t451);
    let t453 = circuit_sub(in200, in14);
    let t454 = circuit_mul(t447, t453);
    let t455 = circuit_sub(in200, in14);
    let t456 = circuit_mul(in8, t455);
    let t457 = circuit_inverse(t456);
    let t458 = circuit_mul(in89, t457);
    let t459 = circuit_add(t452, t458);
    let t460 = circuit_sub(in200, in15);
    let t461 = circuit_mul(t454, t460);
    let t462 = circuit_sub(in200, in15);
    let t463 = circuit_mul(in9, t462);
    let t464 = circuit_inverse(t463);
    let t465 = circuit_mul(in90, t464);
    let t466 = circuit_add(t459, t465);
    let t467 = circuit_sub(in200, in16);
    let t468 = circuit_mul(t461, t467);
    let t469 = circuit_sub(in200, in16);
    let t470 = circuit_mul(in10, t469);
    let t471 = circuit_inverse(t470);
    let t472 = circuit_mul(in91, t471);
    let t473 = circuit_add(t466, t472);
    let t474 = circuit_mul(t473, t468);
    let t475 = circuit_sub(in213, in0);
    let t476 = circuit_mul(in200, t475);
    let t477 = circuit_add(in0, t476);
    let t478 = circuit_mul(t412, t477);
    let t479 = circuit_add(in92, in93);
    let t480 = circuit_sub(t479, t474);
    let t481 = circuit_mul(t480, t417);
    let t482 = circuit_add(t416, t481);
    let t483 = circuit_mul(t417, in227);
    let t484 = circuit_sub(in201, in2);
    let t485 = circuit_mul(in0, t484);
    let t486 = circuit_sub(in201, in2);
    let t487 = circuit_mul(in3, t486);
    let t488 = circuit_inverse(t487);
    let t489 = circuit_mul(in92, t488);
    let t490 = circuit_add(in2, t489);
    let t491 = circuit_sub(in201, in0);
    let t492 = circuit_mul(t485, t491);
    let t493 = circuit_sub(in201, in0);
    let t494 = circuit_mul(in4, t493);
    let t495 = circuit_inverse(t494);
    let t496 = circuit_mul(in93, t495);
    let t497 = circuit_add(t490, t496);
    let t498 = circuit_sub(in201, in11);
    let t499 = circuit_mul(t492, t498);
    let t500 = circuit_sub(in201, in11);
    let t501 = circuit_mul(in5, t500);
    let t502 = circuit_inverse(t501);
    let t503 = circuit_mul(in94, t502);
    let t504 = circuit_add(t497, t503);
    let t505 = circuit_sub(in201, in12);
    let t506 = circuit_mul(t499, t505);
    let t507 = circuit_sub(in201, in12);
    let t508 = circuit_mul(in6, t507);
    let t509 = circuit_inverse(t508);
    let t510 = circuit_mul(in95, t509);
    let t511 = circuit_add(t504, t510);
    let t512 = circuit_sub(in201, in13);
    let t513 = circuit_mul(t506, t512);
    let t514 = circuit_sub(in201, in13);
    let t515 = circuit_mul(in7, t514);
    let t516 = circuit_inverse(t515);
    let t517 = circuit_mul(in96, t516);
    let t518 = circuit_add(t511, t517);
    let t519 = circuit_sub(in201, in14);
    let t520 = circuit_mul(t513, t519);
    let t521 = circuit_sub(in201, in14);
    let t522 = circuit_mul(in8, t521);
    let t523 = circuit_inverse(t522);
    let t524 = circuit_mul(in97, t523);
    let t525 = circuit_add(t518, t524);
    let t526 = circuit_sub(in201, in15);
    let t527 = circuit_mul(t520, t526);
    let t528 = circuit_sub(in201, in15);
    let t529 = circuit_mul(in9, t528);
    let t530 = circuit_inverse(t529);
    let t531 = circuit_mul(in98, t530);
    let t532 = circuit_add(t525, t531);
    let t533 = circuit_sub(in201, in16);
    let t534 = circuit_mul(t527, t533);
    let t535 = circuit_sub(in201, in16);
    let t536 = circuit_mul(in10, t535);
    let t537 = circuit_inverse(t536);
    let t538 = circuit_mul(in99, t537);
    let t539 = circuit_add(t532, t538);
    let t540 = circuit_mul(t539, t534);
    let t541 = circuit_sub(in214, in0);
    let t542 = circuit_mul(in201, t541);
    let t543 = circuit_add(in0, t542);
    let t544 = circuit_mul(t478, t543);
    let t545 = circuit_add(in100, in101);
    let t546 = circuit_sub(t545, t540);
    let t547 = circuit_mul(t546, t483);
    let t548 = circuit_add(t482, t547);
    let t549 = circuit_mul(t483, in227);
    let t550 = circuit_sub(in202, in2);
    let t551 = circuit_mul(in0, t550);
    let t552 = circuit_sub(in202, in2);
    let t553 = circuit_mul(in3, t552);
    let t554 = circuit_inverse(t553);
    let t555 = circuit_mul(in100, t554);
    let t556 = circuit_add(in2, t555);
    let t557 = circuit_sub(in202, in0);
    let t558 = circuit_mul(t551, t557);
    let t559 = circuit_sub(in202, in0);
    let t560 = circuit_mul(in4, t559);
    let t561 = circuit_inverse(t560);
    let t562 = circuit_mul(in101, t561);
    let t563 = circuit_add(t556, t562);
    let t564 = circuit_sub(in202, in11);
    let t565 = circuit_mul(t558, t564);
    let t566 = circuit_sub(in202, in11);
    let t567 = circuit_mul(in5, t566);
    let t568 = circuit_inverse(t567);
    let t569 = circuit_mul(in102, t568);
    let t570 = circuit_add(t563, t569);
    let t571 = circuit_sub(in202, in12);
    let t572 = circuit_mul(t565, t571);
    let t573 = circuit_sub(in202, in12);
    let t574 = circuit_mul(in6, t573);
    let t575 = circuit_inverse(t574);
    let t576 = circuit_mul(in103, t575);
    let t577 = circuit_add(t570, t576);
    let t578 = circuit_sub(in202, in13);
    let t579 = circuit_mul(t572, t578);
    let t580 = circuit_sub(in202, in13);
    let t581 = circuit_mul(in7, t580);
    let t582 = circuit_inverse(t581);
    let t583 = circuit_mul(in104, t582);
    let t584 = circuit_add(t577, t583);
    let t585 = circuit_sub(in202, in14);
    let t586 = circuit_mul(t579, t585);
    let t587 = circuit_sub(in202, in14);
    let t588 = circuit_mul(in8, t587);
    let t589 = circuit_inverse(t588);
    let t590 = circuit_mul(in105, t589);
    let t591 = circuit_add(t584, t590);
    let t592 = circuit_sub(in202, in15);
    let t593 = circuit_mul(t586, t592);
    let t594 = circuit_sub(in202, in15);
    let t595 = circuit_mul(in9, t594);
    let t596 = circuit_inverse(t595);
    let t597 = circuit_mul(in106, t596);
    let t598 = circuit_add(t591, t597);
    let t599 = circuit_sub(in202, in16);
    let t600 = circuit_mul(t593, t599);
    let t601 = circuit_sub(in202, in16);
    let t602 = circuit_mul(in10, t601);
    let t603 = circuit_inverse(t602);
    let t604 = circuit_mul(in107, t603);
    let t605 = circuit_add(t598, t604);
    let t606 = circuit_mul(t605, t600);
    let t607 = circuit_sub(in215, in0);
    let t608 = circuit_mul(in202, t607);
    let t609 = circuit_add(in0, t608);
    let t610 = circuit_mul(t544, t609);
    let t611 = circuit_add(in108, in109);
    let t612 = circuit_sub(t611, t606);
    let t613 = circuit_mul(t612, t549);
    let t614 = circuit_add(t548, t613);
    let t615 = circuit_mul(t549, in227);
    let t616 = circuit_sub(in203, in2);
    let t617 = circuit_mul(in0, t616);
    let t618 = circuit_sub(in203, in2);
    let t619 = circuit_mul(in3, t618);
    let t620 = circuit_inverse(t619);
    let t621 = circuit_mul(in108, t620);
    let t622 = circuit_add(in2, t621);
    let t623 = circuit_sub(in203, in0);
    let t624 = circuit_mul(t617, t623);
    let t625 = circuit_sub(in203, in0);
    let t626 = circuit_mul(in4, t625);
    let t627 = circuit_inverse(t626);
    let t628 = circuit_mul(in109, t627);
    let t629 = circuit_add(t622, t628);
    let t630 = circuit_sub(in203, in11);
    let t631 = circuit_mul(t624, t630);
    let t632 = circuit_sub(in203, in11);
    let t633 = circuit_mul(in5, t632);
    let t634 = circuit_inverse(t633);
    let t635 = circuit_mul(in110, t634);
    let t636 = circuit_add(t629, t635);
    let t637 = circuit_sub(in203, in12);
    let t638 = circuit_mul(t631, t637);
    let t639 = circuit_sub(in203, in12);
    let t640 = circuit_mul(in6, t639);
    let t641 = circuit_inverse(t640);
    let t642 = circuit_mul(in111, t641);
    let t643 = circuit_add(t636, t642);
    let t644 = circuit_sub(in203, in13);
    let t645 = circuit_mul(t638, t644);
    let t646 = circuit_sub(in203, in13);
    let t647 = circuit_mul(in7, t646);
    let t648 = circuit_inverse(t647);
    let t649 = circuit_mul(in112, t648);
    let t650 = circuit_add(t643, t649);
    let t651 = circuit_sub(in203, in14);
    let t652 = circuit_mul(t645, t651);
    let t653 = circuit_sub(in203, in14);
    let t654 = circuit_mul(in8, t653);
    let t655 = circuit_inverse(t654);
    let t656 = circuit_mul(in113, t655);
    let t657 = circuit_add(t650, t656);
    let t658 = circuit_sub(in203, in15);
    let t659 = circuit_mul(t652, t658);
    let t660 = circuit_sub(in203, in15);
    let t661 = circuit_mul(in9, t660);
    let t662 = circuit_inverse(t661);
    let t663 = circuit_mul(in114, t662);
    let t664 = circuit_add(t657, t663);
    let t665 = circuit_sub(in203, in16);
    let t666 = circuit_mul(t659, t665);
    let t667 = circuit_sub(in203, in16);
    let t668 = circuit_mul(in10, t667);
    let t669 = circuit_inverse(t668);
    let t670 = circuit_mul(in115, t669);
    let t671 = circuit_add(t664, t670);
    let t672 = circuit_mul(t671, t666);
    let t673 = circuit_sub(in216, in0);
    let t674 = circuit_mul(in203, t673);
    let t675 = circuit_add(in0, t674);
    let t676 = circuit_mul(t610, t675);
    let t677 = circuit_add(in116, in117);
    let t678 = circuit_sub(t677, t672);
    let t679 = circuit_mul(t678, t615);
    let t680 = circuit_add(t614, t679);
    let t681 = circuit_mul(t615, in227);
    let t682 = circuit_sub(in204, in2);
    let t683 = circuit_mul(in0, t682);
    let t684 = circuit_sub(in204, in2);
    let t685 = circuit_mul(in3, t684);
    let t686 = circuit_inverse(t685);
    let t687 = circuit_mul(in116, t686);
    let t688 = circuit_add(in2, t687);
    let t689 = circuit_sub(in204, in0);
    let t690 = circuit_mul(t683, t689);
    let t691 = circuit_sub(in204, in0);
    let t692 = circuit_mul(in4, t691);
    let t693 = circuit_inverse(t692);
    let t694 = circuit_mul(in117, t693);
    let t695 = circuit_add(t688, t694);
    let t696 = circuit_sub(in204, in11);
    let t697 = circuit_mul(t690, t696);
    let t698 = circuit_sub(in204, in11);
    let t699 = circuit_mul(in5, t698);
    let t700 = circuit_inverse(t699);
    let t701 = circuit_mul(in118, t700);
    let t702 = circuit_add(t695, t701);
    let t703 = circuit_sub(in204, in12);
    let t704 = circuit_mul(t697, t703);
    let t705 = circuit_sub(in204, in12);
    let t706 = circuit_mul(in6, t705);
    let t707 = circuit_inverse(t706);
    let t708 = circuit_mul(in119, t707);
    let t709 = circuit_add(t702, t708);
    let t710 = circuit_sub(in204, in13);
    let t711 = circuit_mul(t704, t710);
    let t712 = circuit_sub(in204, in13);
    let t713 = circuit_mul(in7, t712);
    let t714 = circuit_inverse(t713);
    let t715 = circuit_mul(in120, t714);
    let t716 = circuit_add(t709, t715);
    let t717 = circuit_sub(in204, in14);
    let t718 = circuit_mul(t711, t717);
    let t719 = circuit_sub(in204, in14);
    let t720 = circuit_mul(in8, t719);
    let t721 = circuit_inverse(t720);
    let t722 = circuit_mul(in121, t721);
    let t723 = circuit_add(t716, t722);
    let t724 = circuit_sub(in204, in15);
    let t725 = circuit_mul(t718, t724);
    let t726 = circuit_sub(in204, in15);
    let t727 = circuit_mul(in9, t726);
    let t728 = circuit_inverse(t727);
    let t729 = circuit_mul(in122, t728);
    let t730 = circuit_add(t723, t729);
    let t731 = circuit_sub(in204, in16);
    let t732 = circuit_mul(t725, t731);
    let t733 = circuit_sub(in204, in16);
    let t734 = circuit_mul(in10, t733);
    let t735 = circuit_inverse(t734);
    let t736 = circuit_mul(in123, t735);
    let t737 = circuit_add(t730, t736);
    let t738 = circuit_mul(t737, t732);
    let t739 = circuit_sub(in217, in0);
    let t740 = circuit_mul(in204, t739);
    let t741 = circuit_add(in0, t740);
    let t742 = circuit_mul(t676, t741);
    let t743 = circuit_add(in124, in125);
    let t744 = circuit_sub(t743, t738);
    let t745 = circuit_mul(t744, t681);
    let t746 = circuit_add(t680, t745);
    let t747 = circuit_mul(t681, in227);
    let t748 = circuit_sub(in205, in2);
    let t749 = circuit_mul(in0, t748);
    let t750 = circuit_sub(in205, in2);
    let t751 = circuit_mul(in3, t750);
    let t752 = circuit_inverse(t751);
    let t753 = circuit_mul(in124, t752);
    let t754 = circuit_add(in2, t753);
    let t755 = circuit_sub(in205, in0);
    let t756 = circuit_mul(t749, t755);
    let t757 = circuit_sub(in205, in0);
    let t758 = circuit_mul(in4, t757);
    let t759 = circuit_inverse(t758);
    let t760 = circuit_mul(in125, t759);
    let t761 = circuit_add(t754, t760);
    let t762 = circuit_sub(in205, in11);
    let t763 = circuit_mul(t756, t762);
    let t764 = circuit_sub(in205, in11);
    let t765 = circuit_mul(in5, t764);
    let t766 = circuit_inverse(t765);
    let t767 = circuit_mul(in126, t766);
    let t768 = circuit_add(t761, t767);
    let t769 = circuit_sub(in205, in12);
    let t770 = circuit_mul(t763, t769);
    let t771 = circuit_sub(in205, in12);
    let t772 = circuit_mul(in6, t771);
    let t773 = circuit_inverse(t772);
    let t774 = circuit_mul(in127, t773);
    let t775 = circuit_add(t768, t774);
    let t776 = circuit_sub(in205, in13);
    let t777 = circuit_mul(t770, t776);
    let t778 = circuit_sub(in205, in13);
    let t779 = circuit_mul(in7, t778);
    let t780 = circuit_inverse(t779);
    let t781 = circuit_mul(in128, t780);
    let t782 = circuit_add(t775, t781);
    let t783 = circuit_sub(in205, in14);
    let t784 = circuit_mul(t777, t783);
    let t785 = circuit_sub(in205, in14);
    let t786 = circuit_mul(in8, t785);
    let t787 = circuit_inverse(t786);
    let t788 = circuit_mul(in129, t787);
    let t789 = circuit_add(t782, t788);
    let t790 = circuit_sub(in205, in15);
    let t791 = circuit_mul(t784, t790);
    let t792 = circuit_sub(in205, in15);
    let t793 = circuit_mul(in9, t792);
    let t794 = circuit_inverse(t793);
    let t795 = circuit_mul(in130, t794);
    let t796 = circuit_add(t789, t795);
    let t797 = circuit_sub(in205, in16);
    let t798 = circuit_mul(t791, t797);
    let t799 = circuit_sub(in205, in16);
    let t800 = circuit_mul(in10, t799);
    let t801 = circuit_inverse(t800);
    let t802 = circuit_mul(in131, t801);
    let t803 = circuit_add(t796, t802);
    let t804 = circuit_mul(t803, t798);
    let t805 = circuit_sub(in218, in0);
    let t806 = circuit_mul(in205, t805);
    let t807 = circuit_add(in0, t806);
    let t808 = circuit_mul(t742, t807);
    let t809 = circuit_add(in132, in133);
    let t810 = circuit_sub(t809, t804);
    let t811 = circuit_mul(t810, t747);
    let t812 = circuit_add(t746, t811);
    let t813 = circuit_mul(t747, in227);
    let t814 = circuit_sub(in206, in2);
    let t815 = circuit_mul(in0, t814);
    let t816 = circuit_sub(in206, in2);
    let t817 = circuit_mul(in3, t816);
    let t818 = circuit_inverse(t817);
    let t819 = circuit_mul(in132, t818);
    let t820 = circuit_add(in2, t819);
    let t821 = circuit_sub(in206, in0);
    let t822 = circuit_mul(t815, t821);
    let t823 = circuit_sub(in206, in0);
    let t824 = circuit_mul(in4, t823);
    let t825 = circuit_inverse(t824);
    let t826 = circuit_mul(in133, t825);
    let t827 = circuit_add(t820, t826);
    let t828 = circuit_sub(in206, in11);
    let t829 = circuit_mul(t822, t828);
    let t830 = circuit_sub(in206, in11);
    let t831 = circuit_mul(in5, t830);
    let t832 = circuit_inverse(t831);
    let t833 = circuit_mul(in134, t832);
    let t834 = circuit_add(t827, t833);
    let t835 = circuit_sub(in206, in12);
    let t836 = circuit_mul(t829, t835);
    let t837 = circuit_sub(in206, in12);
    let t838 = circuit_mul(in6, t837);
    let t839 = circuit_inverse(t838);
    let t840 = circuit_mul(in135, t839);
    let t841 = circuit_add(t834, t840);
    let t842 = circuit_sub(in206, in13);
    let t843 = circuit_mul(t836, t842);
    let t844 = circuit_sub(in206, in13);
    let t845 = circuit_mul(in7, t844);
    let t846 = circuit_inverse(t845);
    let t847 = circuit_mul(in136, t846);
    let t848 = circuit_add(t841, t847);
    let t849 = circuit_sub(in206, in14);
    let t850 = circuit_mul(t843, t849);
    let t851 = circuit_sub(in206, in14);
    let t852 = circuit_mul(in8, t851);
    let t853 = circuit_inverse(t852);
    let t854 = circuit_mul(in137, t853);
    let t855 = circuit_add(t848, t854);
    let t856 = circuit_sub(in206, in15);
    let t857 = circuit_mul(t850, t856);
    let t858 = circuit_sub(in206, in15);
    let t859 = circuit_mul(in9, t858);
    let t860 = circuit_inverse(t859);
    let t861 = circuit_mul(in138, t860);
    let t862 = circuit_add(t855, t861);
    let t863 = circuit_sub(in206, in16);
    let t864 = circuit_mul(t857, t863);
    let t865 = circuit_sub(in206, in16);
    let t866 = circuit_mul(in10, t865);
    let t867 = circuit_inverse(t866);
    let t868 = circuit_mul(in139, t867);
    let t869 = circuit_add(t862, t868);
    let t870 = circuit_mul(t869, t864);
    let t871 = circuit_sub(in219, in0);
    let t872 = circuit_mul(in206, t871);
    let t873 = circuit_add(in0, t872);
    let t874 = circuit_mul(t808, t873);
    let t875 = circuit_add(in140, in141);
    let t876 = circuit_sub(t875, t870);
    let t877 = circuit_mul(t876, t813);
    let t878 = circuit_add(t812, t877);
    let t879 = circuit_mul(t813, in227);
    let t880 = circuit_sub(in207, in2);
    let t881 = circuit_mul(in0, t880);
    let t882 = circuit_sub(in207, in2);
    let t883 = circuit_mul(in3, t882);
    let t884 = circuit_inverse(t883);
    let t885 = circuit_mul(in140, t884);
    let t886 = circuit_add(in2, t885);
    let t887 = circuit_sub(in207, in0);
    let t888 = circuit_mul(t881, t887);
    let t889 = circuit_sub(in207, in0);
    let t890 = circuit_mul(in4, t889);
    let t891 = circuit_inverse(t890);
    let t892 = circuit_mul(in141, t891);
    let t893 = circuit_add(t886, t892);
    let t894 = circuit_sub(in207, in11);
    let t895 = circuit_mul(t888, t894);
    let t896 = circuit_sub(in207, in11);
    let t897 = circuit_mul(in5, t896);
    let t898 = circuit_inverse(t897);
    let t899 = circuit_mul(in142, t898);
    let t900 = circuit_add(t893, t899);
    let t901 = circuit_sub(in207, in12);
    let t902 = circuit_mul(t895, t901);
    let t903 = circuit_sub(in207, in12);
    let t904 = circuit_mul(in6, t903);
    let t905 = circuit_inverse(t904);
    let t906 = circuit_mul(in143, t905);
    let t907 = circuit_add(t900, t906);
    let t908 = circuit_sub(in207, in13);
    let t909 = circuit_mul(t902, t908);
    let t910 = circuit_sub(in207, in13);
    let t911 = circuit_mul(in7, t910);
    let t912 = circuit_inverse(t911);
    let t913 = circuit_mul(in144, t912);
    let t914 = circuit_add(t907, t913);
    let t915 = circuit_sub(in207, in14);
    let t916 = circuit_mul(t909, t915);
    let t917 = circuit_sub(in207, in14);
    let t918 = circuit_mul(in8, t917);
    let t919 = circuit_inverse(t918);
    let t920 = circuit_mul(in145, t919);
    let t921 = circuit_add(t914, t920);
    let t922 = circuit_sub(in207, in15);
    let t923 = circuit_mul(t916, t922);
    let t924 = circuit_sub(in207, in15);
    let t925 = circuit_mul(in9, t924);
    let t926 = circuit_inverse(t925);
    let t927 = circuit_mul(in146, t926);
    let t928 = circuit_add(t921, t927);
    let t929 = circuit_sub(in207, in16);
    let t930 = circuit_mul(t923, t929);
    let t931 = circuit_sub(in207, in16);
    let t932 = circuit_mul(in10, t931);
    let t933 = circuit_inverse(t932);
    let t934 = circuit_mul(in147, t933);
    let t935 = circuit_add(t928, t934);
    let t936 = circuit_mul(t935, t930);
    let t937 = circuit_sub(in220, in0);
    let t938 = circuit_mul(in207, t937);
    let t939 = circuit_add(in0, t938);
    let t940 = circuit_mul(t874, t939);
    let t941 = circuit_add(in148, in149);
    let t942 = circuit_sub(t941, t936);
    let t943 = circuit_mul(t942, t879);
    let t944 = circuit_add(t878, t943);
    let t945 = circuit_sub(in208, in2);
    let t946 = circuit_mul(in0, t945);
    let t947 = circuit_sub(in208, in2);
    let t948 = circuit_mul(in3, t947);
    let t949 = circuit_inverse(t948);
    let t950 = circuit_mul(in148, t949);
    let t951 = circuit_add(in2, t950);
    let t952 = circuit_sub(in208, in0);
    let t953 = circuit_mul(t946, t952);
    let t954 = circuit_sub(in208, in0);
    let t955 = circuit_mul(in4, t954);
    let t956 = circuit_inverse(t955);
    let t957 = circuit_mul(in149, t956);
    let t958 = circuit_add(t951, t957);
    let t959 = circuit_sub(in208, in11);
    let t960 = circuit_mul(t953, t959);
    let t961 = circuit_sub(in208, in11);
    let t962 = circuit_mul(in5, t961);
    let t963 = circuit_inverse(t962);
    let t964 = circuit_mul(in150, t963);
    let t965 = circuit_add(t958, t964);
    let t966 = circuit_sub(in208, in12);
    let t967 = circuit_mul(t960, t966);
    let t968 = circuit_sub(in208, in12);
    let t969 = circuit_mul(in6, t968);
    let t970 = circuit_inverse(t969);
    let t971 = circuit_mul(in151, t970);
    let t972 = circuit_add(t965, t971);
    let t973 = circuit_sub(in208, in13);
    let t974 = circuit_mul(t967, t973);
    let t975 = circuit_sub(in208, in13);
    let t976 = circuit_mul(in7, t975);
    let t977 = circuit_inverse(t976);
    let t978 = circuit_mul(in152, t977);
    let t979 = circuit_add(t972, t978);
    let t980 = circuit_sub(in208, in14);
    let t981 = circuit_mul(t974, t980);
    let t982 = circuit_sub(in208, in14);
    let t983 = circuit_mul(in8, t982);
    let t984 = circuit_inverse(t983);
    let t985 = circuit_mul(in153, t984);
    let t986 = circuit_add(t979, t985);
    let t987 = circuit_sub(in208, in15);
    let t988 = circuit_mul(t981, t987);
    let t989 = circuit_sub(in208, in15);
    let t990 = circuit_mul(in9, t989);
    let t991 = circuit_inverse(t990);
    let t992 = circuit_mul(in154, t991);
    let t993 = circuit_add(t986, t992);
    let t994 = circuit_sub(in208, in16);
    let t995 = circuit_mul(t988, t994);
    let t996 = circuit_sub(in208, in16);
    let t997 = circuit_mul(in10, t996);
    let t998 = circuit_inverse(t997);
    let t999 = circuit_mul(in155, t998);
    let t1000 = circuit_add(t993, t999);
    let t1001 = circuit_mul(t1000, t995);
    let t1002 = circuit_sub(in221, in0);
    let t1003 = circuit_mul(in208, t1002);
    let t1004 = circuit_add(in0, t1003);
    let t1005 = circuit_mul(t940, t1004);
    let t1006 = circuit_sub(in163, in12);
    let t1007 = circuit_mul(t1006, in156);
    let t1008 = circuit_mul(t1007, in184);
    let t1009 = circuit_mul(t1008, in183);
    let t1010 = circuit_mul(t1009, in17);
    let t1011 = circuit_mul(in158, in183);
    let t1012 = circuit_mul(in159, in184);
    let t1013 = circuit_mul(in160, in185);
    let t1014 = circuit_mul(in161, in186);
    let t1015 = circuit_add(t1010, t1011);
    let t1016 = circuit_add(t1015, t1012);
    let t1017 = circuit_add(t1016, t1013);
    let t1018 = circuit_add(t1017, t1014);
    let t1019 = circuit_add(t1018, in157);
    let t1020 = circuit_sub(in163, in0);
    let t1021 = circuit_mul(t1020, in194);
    let t1022 = circuit_add(t1019, t1021);
    let t1023 = circuit_mul(t1022, in163);
    let t1024 = circuit_mul(t1023, t1005);
    let t1025 = circuit_add(in183, in186);
    let t1026 = circuit_add(t1025, in156);
    let t1027 = circuit_sub(t1026, in191);
    let t1028 = circuit_sub(in163, in11);
    let t1029 = circuit_mul(t1027, t1028);
    let t1030 = circuit_sub(in163, in0);
    let t1031 = circuit_mul(t1029, t1030);
    let t1032 = circuit_mul(t1031, in163);
    let t1033 = circuit_mul(t1032, t1005);
    let t1034 = circuit_mul(in173, in225);
    let t1035 = circuit_add(in183, t1034);
    let t1036 = circuit_add(t1035, in226);
    let t1037 = circuit_mul(in174, in225);
    let t1038 = circuit_add(in184, t1037);
    let t1039 = circuit_add(t1038, in226);
    let t1040 = circuit_mul(t1036, t1039);
    let t1041 = circuit_mul(in175, in225);
    let t1042 = circuit_add(in185, t1041);
    let t1043 = circuit_add(t1042, in226);
    let t1044 = circuit_mul(t1040, t1043);
    let t1045 = circuit_mul(in176, in225);
    let t1046 = circuit_add(in186, t1045);
    let t1047 = circuit_add(t1046, in226);
    let t1048 = circuit_mul(t1044, t1047);
    let t1049 = circuit_mul(in169, in225);
    let t1050 = circuit_add(in183, t1049);
    let t1051 = circuit_add(t1050, in226);
    let t1052 = circuit_mul(in170, in225);
    let t1053 = circuit_add(in184, t1052);
    let t1054 = circuit_add(t1053, in226);
    let t1055 = circuit_mul(t1051, t1054);
    let t1056 = circuit_mul(in171, in225);
    let t1057 = circuit_add(in185, t1056);
    let t1058 = circuit_add(t1057, in226);
    let t1059 = circuit_mul(t1055, t1058);
    let t1060 = circuit_mul(in172, in225);
    let t1061 = circuit_add(in186, t1060);
    let t1062 = circuit_add(t1061, in226);
    let t1063 = circuit_mul(t1059, t1062);
    let t1064 = circuit_add(in187, in181);
    let t1065 = circuit_mul(t1048, t1064);
    let t1066 = circuit_mul(in182, t149);
    let t1067 = circuit_add(in195, t1066);
    let t1068 = circuit_mul(t1063, t1067);
    let t1069 = circuit_sub(t1065, t1068);
    let t1070 = circuit_mul(t1069, t1005);
    let t1071 = circuit_mul(in182, in195);
    let t1072 = circuit_mul(t1071, t1005);
    let t1073 = circuit_mul(in178, in222);
    let t1074 = circuit_mul(in179, in223);
    let t1075 = circuit_mul(in180, in224);
    let t1076 = circuit_add(in177, in226);
    let t1077 = circuit_add(t1076, t1073);
    let t1078 = circuit_add(t1077, t1074);
    let t1079 = circuit_add(t1078, t1075);
    let t1080 = circuit_mul(in159, in191);
    let t1081 = circuit_add(in183, in226);
    let t1082 = circuit_add(t1081, t1080);
    let t1083 = circuit_mul(in156, in192);
    let t1084 = circuit_add(in184, t1083);
    let t1085 = circuit_mul(in157, in193);
    let t1086 = circuit_add(in185, t1085);
    let t1087 = circuit_mul(t1084, in222);
    let t1088 = circuit_mul(t1086, in223);
    let t1089 = circuit_mul(in160, in224);
    let t1090 = circuit_add(t1082, t1087);
    let t1091 = circuit_add(t1090, t1088);
    let t1092 = circuit_add(t1091, t1089);
    let t1093 = circuit_mul(in188, t1079);
    let t1094 = circuit_mul(in188, t1092);
    let t1095 = circuit_add(in190, in162);
    let t1096 = circuit_mul(in190, in162);
    let t1097 = circuit_sub(t1095, t1096);
    let t1098 = circuit_mul(t1092, t1079);
    let t1099 = circuit_mul(t1098, in188);
    let t1100 = circuit_sub(t1099, t1097);
    let t1101 = circuit_mul(t1100, t1005);
    let t1102 = circuit_mul(in162, t1093);
    let t1103 = circuit_mul(in189, t1094);
    let t1104 = circuit_sub(t1102, t1103);
    let t1105 = circuit_mul(in164, t1005);
    let t1106 = circuit_sub(in184, in183);
    let t1107 = circuit_sub(in185, in184);
    let t1108 = circuit_sub(in186, in185);
    let t1109 = circuit_sub(in191, in186);
    let t1110 = circuit_add(t1106, in18);
    let t1111 = circuit_add(t1110, in18);
    let t1112 = circuit_add(t1111, in18);
    let t1113 = circuit_mul(t1106, t1110);
    let t1114 = circuit_mul(t1113, t1111);
    let t1115 = circuit_mul(t1114, t1112);
    let t1116 = circuit_mul(t1115, t1105);
    let t1117 = circuit_add(t1107, in18);
    let t1118 = circuit_add(t1117, in18);
    let t1119 = circuit_add(t1118, in18);
    let t1120 = circuit_mul(t1107, t1117);
    let t1121 = circuit_mul(t1120, t1118);
    let t1122 = circuit_mul(t1121, t1119);
    let t1123 = circuit_mul(t1122, t1105);
    let t1124 = circuit_add(t1108, in18);
    let t1125 = circuit_add(t1124, in18);
    let t1126 = circuit_add(t1125, in18);
    let t1127 = circuit_mul(t1108, t1124);
    let t1128 = circuit_mul(t1127, t1125);
    let t1129 = circuit_mul(t1128, t1126);
    let t1130 = circuit_mul(t1129, t1105);
    let t1131 = circuit_add(t1109, in18);
    let t1132 = circuit_add(t1131, in18);
    let t1133 = circuit_add(t1132, in18);
    let t1134 = circuit_mul(t1109, t1131);
    let t1135 = circuit_mul(t1134, t1132);
    let t1136 = circuit_mul(t1135, t1133);
    let t1137 = circuit_mul(t1136, t1105);
    let t1138 = circuit_sub(in191, in184);
    let t1139 = circuit_mul(in185, in185);
    let t1140 = circuit_mul(in194, in194);
    let t1141 = circuit_mul(in185, in194);
    let t1142 = circuit_mul(t1141, in158);
    let t1143 = circuit_add(in192, in191);
    let t1144 = circuit_add(t1143, in184);
    let t1145 = circuit_mul(t1144, t1138);
    let t1146 = circuit_mul(t1145, t1138);
    let t1147 = circuit_sub(t1146, t1140);
    let t1148 = circuit_sub(t1147, t1139);
    let t1149 = circuit_add(t1148, t1142);
    let t1150 = circuit_add(t1149, t1142);
    let t1151 = circuit_sub(in0, in156);
    let t1152 = circuit_mul(t1150, t1005);
    let t1153 = circuit_mul(t1152, in165);
    let t1154 = circuit_mul(t1153, t1151);
    let t1155 = circuit_add(in185, in193);
    let t1156 = circuit_mul(in194, in158);
    let t1157 = circuit_sub(t1156, in185);
    let t1158 = circuit_mul(t1155, t1138);
    let t1159 = circuit_sub(in192, in184);
    let t1160 = circuit_mul(t1159, t1157);
    let t1161 = circuit_add(t1158, t1160);
    let t1162 = circuit_mul(t1161, t1005);
    let t1163 = circuit_mul(t1162, in165);
    let t1164 = circuit_mul(t1163, t1151);
    let t1165 = circuit_add(t1139, in19);
    let t1166 = circuit_mul(t1165, in184);
    let t1167 = circuit_add(t1139, t1139);
    let t1168 = circuit_add(t1167, t1167);
    let t1169 = circuit_mul(t1166, in20);
    let t1170 = circuit_add(in192, in184);
    let t1171 = circuit_add(t1170, in184);
    let t1172 = circuit_mul(t1171, t1168);
    let t1173 = circuit_sub(t1172, t1169);
    let t1174 = circuit_mul(t1173, t1005);
    let t1175 = circuit_mul(t1174, in165);
    let t1176 = circuit_mul(t1175, in156);
    let t1177 = circuit_add(t1154, t1176);
    let t1178 = circuit_add(in184, in184);
    let t1179 = circuit_add(t1178, in184);
    let t1180 = circuit_mul(t1179, in184);
    let t1181 = circuit_sub(in184, in192);
    let t1182 = circuit_mul(t1180, t1181);
    let t1183 = circuit_add(in185, in185);
    let t1184 = circuit_add(in185, in193);
    let t1185 = circuit_mul(t1183, t1184);
    let t1186 = circuit_sub(t1182, t1185);
    let t1187 = circuit_mul(t1186, t1005);
    let t1188 = circuit_mul(t1187, in165);
    let t1189 = circuit_mul(t1188, in156);
    let t1190 = circuit_add(t1164, t1189);
    let t1191 = circuit_mul(in183, in192);
    let t1192 = circuit_mul(in191, in184);
    let t1193 = circuit_add(t1191, t1192);
    let t1194 = circuit_mul(in183, in186);
    let t1195 = circuit_mul(in184, in185);
    let t1196 = circuit_add(t1194, t1195);
    let t1197 = circuit_sub(t1196, in193);
    let t1198 = circuit_mul(t1197, in21);
    let t1199 = circuit_sub(t1198, in194);
    let t1200 = circuit_add(t1199, t1193);
    let t1201 = circuit_mul(t1200, in161);
    let t1202 = circuit_mul(t1193, in21);
    let t1203 = circuit_mul(in191, in192);
    let t1204 = circuit_add(t1202, t1203);
    let t1205 = circuit_add(in185, in186);
    let t1206 = circuit_sub(t1204, t1205);
    let t1207 = circuit_mul(t1206, in160);
    let t1208 = circuit_add(t1204, in186);
    let t1209 = circuit_add(in193, in194);
    let t1210 = circuit_sub(t1208, t1209);
    let t1211 = circuit_mul(t1210, in156);
    let t1212 = circuit_add(t1207, t1201);
    let t1213 = circuit_add(t1212, t1211);
    let t1214 = circuit_mul(t1213, in159);
    let t1215 = circuit_mul(in192, in22);
    let t1216 = circuit_add(t1215, in191);
    let t1217 = circuit_mul(t1216, in22);
    let t1218 = circuit_add(t1217, in185);
    let t1219 = circuit_mul(t1218, in22);
    let t1220 = circuit_add(t1219, in184);
    let t1221 = circuit_mul(t1220, in22);
    let t1222 = circuit_add(t1221, in183);
    let t1223 = circuit_sub(t1222, in186);
    let t1224 = circuit_mul(t1223, in161);
    let t1225 = circuit_mul(in193, in22);
    let t1226 = circuit_add(t1225, in192);
    let t1227 = circuit_mul(t1226, in22);
    let t1228 = circuit_add(t1227, in191);
    let t1229 = circuit_mul(t1228, in22);
    let t1230 = circuit_add(t1229, in186);
    let t1231 = circuit_mul(t1230, in22);
    let t1232 = circuit_add(t1231, in185);
    let t1233 = circuit_sub(t1232, in194);
    let t1234 = circuit_mul(t1233, in156);
    let t1235 = circuit_add(t1224, t1234);
    let t1236 = circuit_mul(t1235, in160);
    let t1237 = circuit_mul(in185, in224);
    let t1238 = circuit_mul(in184, in223);
    let t1239 = circuit_mul(in183, in222);
    let t1240 = circuit_add(t1237, t1238);
    let t1241 = circuit_add(t1240, t1239);
    let t1242 = circuit_add(t1241, in157);
    let t1243 = circuit_sub(t1242, in186);
    let t1244 = circuit_sub(in191, in183);
    let t1245 = circuit_sub(in194, in186);
    let t1246 = circuit_mul(t1244, t1244);
    let t1247 = circuit_sub(t1246, t1244);
    let t1248 = circuit_sub(in2, t1244);
    let t1249 = circuit_add(t1248, in0);
    let t1250 = circuit_mul(t1249, t1245);
    let t1251 = circuit_mul(in158, in159);
    let t1252 = circuit_mul(t1251, in166);
    let t1253 = circuit_mul(t1252, t1005);
    let t1254 = circuit_mul(t1250, t1253);
    let t1255 = circuit_mul(t1247, t1253);
    let t1256 = circuit_mul(t1243, t1251);
    let t1257 = circuit_sub(in186, t1242);
    let t1258 = circuit_mul(t1257, t1257);
    let t1259 = circuit_sub(t1258, t1257);
    let t1260 = circuit_mul(in193, in224);
    let t1261 = circuit_mul(in192, in223);
    let t1262 = circuit_mul(in191, in222);
    let t1263 = circuit_add(t1260, t1261);
    let t1264 = circuit_add(t1263, t1262);
    let t1265 = circuit_sub(in194, t1264);
    let t1266 = circuit_sub(in193, in185);
    let t1267 = circuit_sub(in2, t1244);
    let t1268 = circuit_add(t1267, in0);
    let t1269 = circuit_sub(in2, t1265);
    let t1270 = circuit_add(t1269, in0);
    let t1271 = circuit_mul(t1266, t1270);
    let t1272 = circuit_mul(t1268, t1271);
    let t1273 = circuit_mul(t1265, t1265);
    let t1274 = circuit_sub(t1273, t1265);
    let t1275 = circuit_mul(in163, in166);
    let t1276 = circuit_mul(t1275, t1005);
    let t1277 = circuit_mul(t1272, t1276);
    let t1278 = circuit_mul(t1247, t1276);
    let t1279 = circuit_mul(t1274, t1276);
    let t1280 = circuit_mul(t1259, in163);
    let t1281 = circuit_sub(in192, in184);
    let t1282 = circuit_sub(in2, t1244);
    let t1283 = circuit_add(t1282, in0);
    let t1284 = circuit_mul(t1283, t1281);
    let t1285 = circuit_sub(t1284, in185);
    let t1286 = circuit_mul(t1285, in161);
    let t1287 = circuit_mul(t1286, in158);
    let t1288 = circuit_add(t1256, t1287);
    let t1289 = circuit_mul(t1243, in156);
    let t1290 = circuit_mul(t1289, in158);
    let t1291 = circuit_add(t1288, t1290);
    let t1292 = circuit_add(t1291, t1280);
    let t1293 = circuit_add(t1292, t1214);
    let t1294 = circuit_add(t1293, t1236);
    let t1295 = circuit_mul(t1294, in166);
    let t1296 = circuit_mul(t1295, t1005);
    let t1297 = circuit_add(in183, in158);
    let t1298 = circuit_add(in184, in159);
    let t1299 = circuit_add(in185, in160);
    let t1300 = circuit_add(in186, in161);
    let t1301 = circuit_mul(t1297, t1297);
    let t1302 = circuit_mul(t1301, t1301);
    let t1303 = circuit_mul(t1302, t1297);
    let t1304 = circuit_mul(t1298, t1298);
    let t1305 = circuit_mul(t1304, t1304);
    let t1306 = circuit_mul(t1305, t1298);
    let t1307 = circuit_mul(t1299, t1299);
    let t1308 = circuit_mul(t1307, t1307);
    let t1309 = circuit_mul(t1308, t1299);
    let t1310 = circuit_mul(t1300, t1300);
    let t1311 = circuit_mul(t1310, t1310);
    let t1312 = circuit_mul(t1311, t1300);
    let t1313 = circuit_add(t1303, t1306);
    let t1314 = circuit_add(t1309, t1312);
    let t1315 = circuit_add(t1306, t1306);
    let t1316 = circuit_add(t1315, t1314);
    let t1317 = circuit_add(t1312, t1312);
    let t1318 = circuit_add(t1317, t1313);
    let t1319 = circuit_add(t1314, t1314);
    let t1320 = circuit_add(t1319, t1319);
    let t1321 = circuit_add(t1320, t1318);
    let t1322 = circuit_add(t1313, t1313);
    let t1323 = circuit_add(t1322, t1322);
    let t1324 = circuit_add(t1323, t1316);
    let t1325 = circuit_add(t1318, t1324);
    let t1326 = circuit_add(t1316, t1321);
    let t1327 = circuit_mul(in167, t1005);
    let t1328 = circuit_sub(t1325, in191);
    let t1329 = circuit_mul(t1327, t1328);
    let t1330 = circuit_sub(t1324, in192);
    let t1331 = circuit_mul(t1327, t1330);
    let t1332 = circuit_sub(t1326, in193);
    let t1333 = circuit_mul(t1327, t1332);
    let t1334 = circuit_sub(t1321, in194);
    let t1335 = circuit_mul(t1327, t1334);
    let t1336 = circuit_add(in183, in158);
    let t1337 = circuit_mul(t1336, t1336);
    let t1338 = circuit_mul(t1337, t1337);
    let t1339 = circuit_mul(t1338, t1336);
    let t1340 = circuit_add(t1339, in184);
    let t1341 = circuit_add(t1340, in185);
    let t1342 = circuit_add(t1341, in186);
    let t1343 = circuit_mul(in168, t1005);
    let t1344 = circuit_mul(t1339, in23);
    let t1345 = circuit_add(t1344, t1342);
    let t1346 = circuit_sub(t1345, in191);
    let t1347 = circuit_mul(t1343, t1346);
    let t1348 = circuit_mul(in184, in24);
    let t1349 = circuit_add(t1348, t1342);
    let t1350 = circuit_sub(t1349, in192);
    let t1351 = circuit_mul(t1343, t1350);
    let t1352 = circuit_mul(in185, in25);
    let t1353 = circuit_add(t1352, t1342);
    let t1354 = circuit_sub(t1353, in193);
    let t1355 = circuit_mul(t1343, t1354);
    let t1356 = circuit_mul(in186, in26);
    let t1357 = circuit_add(t1356, t1342);
    let t1358 = circuit_sub(t1357, in194);
    let t1359 = circuit_mul(t1343, t1358);
    let t1360 = circuit_mul(t1033, in228);
    let t1361 = circuit_add(t1024, t1360);
    let t1362 = circuit_mul(t1070, in229);
    let t1363 = circuit_add(t1361, t1362);
    let t1364 = circuit_mul(t1072, in230);
    let t1365 = circuit_add(t1363, t1364);
    let t1366 = circuit_mul(t1101, in231);
    let t1367 = circuit_add(t1365, t1366);
    let t1368 = circuit_mul(t1104, in232);
    let t1369 = circuit_add(t1367, t1368);
    let t1370 = circuit_mul(t1116, in233);
    let t1371 = circuit_add(t1369, t1370);
    let t1372 = circuit_mul(t1123, in234);
    let t1373 = circuit_add(t1371, t1372);
    let t1374 = circuit_mul(t1130, in235);
    let t1375 = circuit_add(t1373, t1374);
    let t1376 = circuit_mul(t1137, in236);
    let t1377 = circuit_add(t1375, t1376);
    let t1378 = circuit_mul(t1177, in237);
    let t1379 = circuit_add(t1377, t1378);
    let t1380 = circuit_mul(t1190, in238);
    let t1381 = circuit_add(t1379, t1380);
    let t1382 = circuit_mul(t1296, in239);
    let t1383 = circuit_add(t1381, t1382);
    let t1384 = circuit_mul(t1254, in240);
    let t1385 = circuit_add(t1383, t1384);
    let t1386 = circuit_mul(t1255, in241);
    let t1387 = circuit_add(t1385, t1386);
    let t1388 = circuit_mul(t1277, in242);
    let t1389 = circuit_add(t1387, t1388);
    let t1390 = circuit_mul(t1278, in243);
    let t1391 = circuit_add(t1389, t1390);
    let t1392 = circuit_mul(t1279, in244);
    let t1393 = circuit_add(t1391, t1392);
    let t1394 = circuit_mul(t1329, in245);
    let t1395 = circuit_add(t1393, t1394);
    let t1396 = circuit_mul(t1331, in246);
    let t1397 = circuit_add(t1395, t1396);
    let t1398 = circuit_mul(t1333, in247);
    let t1399 = circuit_add(t1397, t1398);
    let t1400 = circuit_mul(t1335, in248);
    let t1401 = circuit_add(t1399, t1400);
    let t1402 = circuit_mul(t1347, in249);
    let t1403 = circuit_add(t1401, t1402);
    let t1404 = circuit_mul(t1351, in250);
    let t1405 = circuit_add(t1403, t1404);
    let t1406 = circuit_mul(t1355, in251);
    let t1407 = circuit_add(t1405, t1406);
    let t1408 = circuit_mul(t1359, in252);
    let t1409 = circuit_add(t1407, t1408);
    let t1410 = circuit_sub(t1409, t1001);

    let modulus = modulus;

    let mut circuit_inputs = (t944, t1410).new_inputs();
    // Prefill constants:

    circuit_inputs = circuit_inputs
        .next_span(HONK_SUMCHECK_SIZE_13_PUB_24_GRUMPKIN_CONSTANTS.span()); // in0 - in26

    // Fill inputs:

    for val in p_public_inputs {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in27 - in34

    for val in p_pairing_point_object {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in35 - in50

    circuit_inputs = circuit_inputs.next_2(p_public_inputs_offset); // in51

    for val in sumcheck_univariates_flat {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in52 - in155

    for val in sumcheck_evaluations {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in156 - in195

    for val in tp_sum_check_u_challenges {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in196 - in208

    for val in tp_gate_challenges {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in209 - in221

    circuit_inputs = circuit_inputs.next_u128(tp_eta_1); // in222
    circuit_inputs = circuit_inputs.next_u128(tp_eta_2); // in223
    circuit_inputs = circuit_inputs.next_u128(tp_eta_3); // in224
    circuit_inputs = circuit_inputs.next_u128(tp_beta); // in225
    circuit_inputs = circuit_inputs.next_u128(tp_gamma); // in226
    circuit_inputs = circuit_inputs.next_2(tp_base_rlc); // in227

    for val in tp_alphas {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in228 - in252

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let check_rlc: u384 = outputs.get_output(t944);
    let check: u384 = outputs.get_output(t1410);
    return (check_rlc, check);
}
const HONK_SUMCHECK_SIZE_13_PUB_24_GRUMPKIN_CONSTANTS: [u384; 27] = [
    u384 { limb0: 0x1, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x2000, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x79b9709143e1f593efffec51,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x2d0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x79b9709143e1f593efffff11,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x90, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x79b9709143e1f593efffff71,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0xf0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x79b9709143e1f593effffd31,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x13b0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x2, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x3, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x4, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x5, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x6, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x7, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x3cdcb848a1f0fac9f8000000,
        limb1: 0xdc2822db40c0ac2e9419f424,
        limb2: 0x183227397098d014,
        limb3: 0x0,
    },
    u384 {
        limb0: 0x79b9709143e1f593f0000000,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x11, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x9, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x100000000000000000, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x4000, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x29ca1d7fb56821fd19d3b6e7,
        limb1: 0x4b1e03b4bd9490c0d03f989,
        limb2: 0x10dc6e9c006ea38b,
        limb3: 0x0,
    },
    u384 {
        limb0: 0xd4dd9b84a86b38cfb45a740b,
        limb1: 0x149b3d0a30b3bb599df9756,
        limb2: 0xc28145b6a44df3e,
        limb3: 0x0,
    },
    u384 {
        limb0: 0x60e3596170067d00141cac15,
        limb1: 0xb2c7645a50392798b21f75bb,
        limb2: 0x544b8338791518,
        limb3: 0x0,
    },
    u384 {
        limb0: 0xb8fa852613bc534433ee428b,
        limb1: 0x2e2e82eb122789e352e105a3,
        limb2: 0x222c01175718386f,
        limb3: 0x0,
    },
];
#[inline(always)]
pub fn run_GRUMPKIN_HONK_PREP_MSM_SCALARS_SIZE_13_circuit(
    p_sumcheck_evaluations: Span<u256>,
    p_gemini_a_evaluations: Span<u256>,
    tp_gemini_r: u384,
    tp_rho: u384,
    tp_shplonk_z: u384,
    tp_shplonk_nu: u384,
    tp_sum_check_u_challenges: Span<u128>,
    modulus: CircuitModulus,
) -> (
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x0
    let in1 = CE::<CI<1>> {}; // 0x1

    // INPUT stack
    let (in2, in3, in4) = (CE::<CI<2>> {}, CE::<CI<3>> {}, CE::<CI<4>> {});
    let (in5, in6, in7) = (CE::<CI<5>> {}, CE::<CI<6>> {}, CE::<CI<7>> {});
    let (in8, in9, in10) = (CE::<CI<8>> {}, CE::<CI<9>> {}, CE::<CI<10>> {});
    let (in11, in12, in13) = (CE::<CI<11>> {}, CE::<CI<12>> {}, CE::<CI<13>> {});
    let (in14, in15, in16) = (CE::<CI<14>> {}, CE::<CI<15>> {}, CE::<CI<16>> {});
    let (in17, in18, in19) = (CE::<CI<17>> {}, CE::<CI<18>> {}, CE::<CI<19>> {});
    let (in20, in21, in22) = (CE::<CI<20>> {}, CE::<CI<21>> {}, CE::<CI<22>> {});
    let (in23, in24, in25) = (CE::<CI<23>> {}, CE::<CI<24>> {}, CE::<CI<25>> {});
    let (in26, in27, in28) = (CE::<CI<26>> {}, CE::<CI<27>> {}, CE::<CI<28>> {});
    let (in29, in30, in31) = (CE::<CI<29>> {}, CE::<CI<30>> {}, CE::<CI<31>> {});
    let (in32, in33, in34) = (CE::<CI<32>> {}, CE::<CI<33>> {}, CE::<CI<34>> {});
    let (in35, in36, in37) = (CE::<CI<35>> {}, CE::<CI<36>> {}, CE::<CI<37>> {});
    let (in38, in39, in40) = (CE::<CI<38>> {}, CE::<CI<39>> {}, CE::<CI<40>> {});
    let (in41, in42, in43) = (CE::<CI<41>> {}, CE::<CI<42>> {}, CE::<CI<43>> {});
    let (in44, in45, in46) = (CE::<CI<44>> {}, CE::<CI<45>> {}, CE::<CI<46>> {});
    let (in47, in48, in49) = (CE::<CI<47>> {}, CE::<CI<48>> {}, CE::<CI<49>> {});
    let (in50, in51, in52) = (CE::<CI<50>> {}, CE::<CI<51>> {}, CE::<CI<52>> {});
    let (in53, in54, in55) = (CE::<CI<53>> {}, CE::<CI<54>> {}, CE::<CI<55>> {});
    let (in56, in57, in58) = (CE::<CI<56>> {}, CE::<CI<57>> {}, CE::<CI<58>> {});
    let (in59, in60, in61) = (CE::<CI<59>> {}, CE::<CI<60>> {}, CE::<CI<61>> {});
    let (in62, in63, in64) = (CE::<CI<62>> {}, CE::<CI<63>> {}, CE::<CI<64>> {});
    let (in65, in66, in67) = (CE::<CI<65>> {}, CE::<CI<66>> {}, CE::<CI<67>> {});
    let (in68, in69, in70) = (CE::<CI<68>> {}, CE::<CI<69>> {}, CE::<CI<70>> {});
    let in71 = CE::<CI<71>> {};
    let t0 = circuit_mul(in55, in55);
    let t1 = circuit_mul(t0, t0);
    let t2 = circuit_mul(t1, t1);
    let t3 = circuit_mul(t2, t2);
    let t4 = circuit_mul(t3, t3);
    let t5 = circuit_mul(t4, t4);
    let t6 = circuit_mul(t5, t5);
    let t7 = circuit_mul(t6, t6);
    let t8 = circuit_mul(t7, t7);
    let t9 = circuit_mul(t8, t8);
    let t10 = circuit_mul(t9, t9);
    let t11 = circuit_mul(t10, t10);
    let t12 = circuit_sub(in57, in55);
    let t13 = circuit_inverse(t12);
    let t14 = circuit_add(in57, in55);
    let t15 = circuit_inverse(t14);
    let t16 = circuit_mul(in58, t15);
    let t17 = circuit_add(t13, t16);
    let t18 = circuit_sub(in0, t17);
    let t19 = circuit_inverse(in55);
    let t20 = circuit_mul(in58, t15);
    let t21 = circuit_sub(t13, t20);
    let t22 = circuit_mul(t19, t21);
    let t23 = circuit_sub(in0, t22);
    let t24 = circuit_mul(t18, in1);
    let t25 = circuit_mul(in2, in1);
    let t26 = circuit_add(in0, t25);
    let t27 = circuit_mul(in1, in56);
    let t28 = circuit_mul(t18, t27);
    let t29 = circuit_mul(in3, t27);
    let t30 = circuit_add(t26, t29);
    let t31 = circuit_mul(t27, in56);
    let t32 = circuit_mul(t18, t31);
    let t33 = circuit_mul(in4, t31);
    let t34 = circuit_add(t30, t33);
    let t35 = circuit_mul(t31, in56);
    let t36 = circuit_mul(t18, t35);
    let t37 = circuit_mul(in5, t35);
    let t38 = circuit_add(t34, t37);
    let t39 = circuit_mul(t35, in56);
    let t40 = circuit_mul(t18, t39);
    let t41 = circuit_mul(in6, t39);
    let t42 = circuit_add(t38, t41);
    let t43 = circuit_mul(t39, in56);
    let t44 = circuit_mul(t18, t43);
    let t45 = circuit_mul(in7, t43);
    let t46 = circuit_add(t42, t45);
    let t47 = circuit_mul(t43, in56);
    let t48 = circuit_mul(t18, t47);
    let t49 = circuit_mul(in8, t47);
    let t50 = circuit_add(t46, t49);
    let t51 = circuit_mul(t47, in56);
    let t52 = circuit_mul(t18, t51);
    let t53 = circuit_mul(in9, t51);
    let t54 = circuit_add(t50, t53);
    let t55 = circuit_mul(t51, in56);
    let t56 = circuit_mul(t18, t55);
    let t57 = circuit_mul(in10, t55);
    let t58 = circuit_add(t54, t57);
    let t59 = circuit_mul(t55, in56);
    let t60 = circuit_mul(t18, t59);
    let t61 = circuit_mul(in11, t59);
    let t62 = circuit_add(t58, t61);
    let t63 = circuit_mul(t59, in56);
    let t64 = circuit_mul(t18, t63);
    let t65 = circuit_mul(in12, t63);
    let t66 = circuit_add(t62, t65);
    let t67 = circuit_mul(t63, in56);
    let t68 = circuit_mul(t18, t67);
    let t69 = circuit_mul(in13, t67);
    let t70 = circuit_add(t66, t69);
    let t71 = circuit_mul(t67, in56);
    let t72 = circuit_mul(t18, t71);
    let t73 = circuit_mul(in14, t71);
    let t74 = circuit_add(t70, t73);
    let t75 = circuit_mul(t71, in56);
    let t76 = circuit_mul(t18, t75);
    let t77 = circuit_mul(in15, t75);
    let t78 = circuit_add(t74, t77);
    let t79 = circuit_mul(t75, in56);
    let t80 = circuit_mul(t18, t79);
    let t81 = circuit_mul(in16, t79);
    let t82 = circuit_add(t78, t81);
    let t83 = circuit_mul(t79, in56);
    let t84 = circuit_mul(t18, t83);
    let t85 = circuit_mul(in17, t83);
    let t86 = circuit_add(t82, t85);
    let t87 = circuit_mul(t83, in56);
    let t88 = circuit_mul(t18, t87);
    let t89 = circuit_mul(in18, t87);
    let t90 = circuit_add(t86, t89);
    let t91 = circuit_mul(t87, in56);
    let t92 = circuit_mul(t18, t91);
    let t93 = circuit_mul(in19, t91);
    let t94 = circuit_add(t90, t93);
    let t95 = circuit_mul(t91, in56);
    let t96 = circuit_mul(t18, t95);
    let t97 = circuit_mul(in20, t95);
    let t98 = circuit_add(t94, t97);
    let t99 = circuit_mul(t95, in56);
    let t100 = circuit_mul(t18, t99);
    let t101 = circuit_mul(in21, t99);
    let t102 = circuit_add(t98, t101);
    let t103 = circuit_mul(t99, in56);
    let t104 = circuit_mul(t18, t103);
    let t105 = circuit_mul(in22, t103);
    let t106 = circuit_add(t102, t105);
    let t107 = circuit_mul(t103, in56);
    let t108 = circuit_mul(t18, t107);
    let t109 = circuit_mul(in23, t107);
    let t110 = circuit_add(t106, t109);
    let t111 = circuit_mul(t107, in56);
    let t112 = circuit_mul(t18, t111);
    let t113 = circuit_mul(in24, t111);
    let t114 = circuit_add(t110, t113);
    let t115 = circuit_mul(t111, in56);
    let t116 = circuit_mul(t18, t115);
    let t117 = circuit_mul(in25, t115);
    let t118 = circuit_add(t114, t117);
    let t119 = circuit_mul(t115, in56);
    let t120 = circuit_mul(t18, t119);
    let t121 = circuit_mul(in26, t119);
    let t122 = circuit_add(t118, t121);
    let t123 = circuit_mul(t119, in56);
    let t124 = circuit_mul(t18, t123);
    let t125 = circuit_mul(in27, t123);
    let t126 = circuit_add(t122, t125);
    let t127 = circuit_mul(t123, in56);
    let t128 = circuit_mul(t18, t127);
    let t129 = circuit_mul(in28, t127);
    let t130 = circuit_add(t126, t129);
    let t131 = circuit_mul(t127, in56);
    let t132 = circuit_mul(t18, t131);
    let t133 = circuit_mul(in29, t131);
    let t134 = circuit_add(t130, t133);
    let t135 = circuit_mul(t131, in56);
    let t136 = circuit_mul(t18, t135);
    let t137 = circuit_mul(in30, t135);
    let t138 = circuit_add(t134, t137);
    let t139 = circuit_mul(t135, in56);
    let t140 = circuit_mul(t18, t139);
    let t141 = circuit_mul(in31, t139);
    let t142 = circuit_add(t138, t141);
    let t143 = circuit_mul(t139, in56);
    let t144 = circuit_mul(t18, t143);
    let t145 = circuit_mul(in32, t143);
    let t146 = circuit_add(t142, t145);
    let t147 = circuit_mul(t143, in56);
    let t148 = circuit_mul(t18, t147);
    let t149 = circuit_mul(in33, t147);
    let t150 = circuit_add(t146, t149);
    let t151 = circuit_mul(t147, in56);
    let t152 = circuit_mul(t18, t151);
    let t153 = circuit_mul(in34, t151);
    let t154 = circuit_add(t150, t153);
    let t155 = circuit_mul(t151, in56);
    let t156 = circuit_mul(t18, t155);
    let t157 = circuit_mul(in35, t155);
    let t158 = circuit_add(t154, t157);
    let t159 = circuit_mul(t155, in56);
    let t160 = circuit_mul(t18, t159);
    let t161 = circuit_mul(in36, t159);
    let t162 = circuit_add(t158, t161);
    let t163 = circuit_mul(t159, in56);
    let t164 = circuit_mul(t23, t163);
    let t165 = circuit_mul(in37, t163);
    let t166 = circuit_add(t162, t165);
    let t167 = circuit_mul(t163, in56);
    let t168 = circuit_mul(t23, t167);
    let t169 = circuit_mul(in38, t167);
    let t170 = circuit_add(t166, t169);
    let t171 = circuit_mul(t167, in56);
    let t172 = circuit_mul(t23, t171);
    let t173 = circuit_mul(in39, t171);
    let t174 = circuit_add(t170, t173);
    let t175 = circuit_mul(t171, in56);
    let t176 = circuit_mul(t23, t175);
    let t177 = circuit_mul(in40, t175);
    let t178 = circuit_add(t174, t177);
    let t179 = circuit_mul(t175, in56);
    let t180 = circuit_mul(t23, t179);
    let t181 = circuit_mul(in41, t179);
    let t182 = circuit_add(t178, t181);
    let t183 = circuit_sub(in1, in71);
    let t184 = circuit_mul(t11, t183);
    let t185 = circuit_mul(t11, t182);
    let t186 = circuit_add(t185, t185);
    let t187 = circuit_sub(t184, in71);
    let t188 = circuit_mul(in54, t187);
    let t189 = circuit_sub(t186, t188);
    let t190 = circuit_add(t184, in71);
    let t191 = circuit_inverse(t190);
    let t192 = circuit_mul(t189, t191);
    let t193 = circuit_sub(in1, in70);
    let t194 = circuit_mul(t10, t193);
    let t195 = circuit_mul(t10, t192);
    let t196 = circuit_add(t195, t195);
    let t197 = circuit_sub(t194, in70);
    let t198 = circuit_mul(in53, t197);
    let t199 = circuit_sub(t196, t198);
    let t200 = circuit_add(t194, in70);
    let t201 = circuit_inverse(t200);
    let t202 = circuit_mul(t199, t201);
    let t203 = circuit_sub(in1, in69);
    let t204 = circuit_mul(t9, t203);
    let t205 = circuit_mul(t9, t202);
    let t206 = circuit_add(t205, t205);
    let t207 = circuit_sub(t204, in69);
    let t208 = circuit_mul(in52, t207);
    let t209 = circuit_sub(t206, t208);
    let t210 = circuit_add(t204, in69);
    let t211 = circuit_inverse(t210);
    let t212 = circuit_mul(t209, t211);
    let t213 = circuit_sub(in1, in68);
    let t214 = circuit_mul(t8, t213);
    let t215 = circuit_mul(t8, t212);
    let t216 = circuit_add(t215, t215);
    let t217 = circuit_sub(t214, in68);
    let t218 = circuit_mul(in51, t217);
    let t219 = circuit_sub(t216, t218);
    let t220 = circuit_add(t214, in68);
    let t221 = circuit_inverse(t220);
    let t222 = circuit_mul(t219, t221);
    let t223 = circuit_sub(in1, in67);
    let t224 = circuit_mul(t7, t223);
    let t225 = circuit_mul(t7, t222);
    let t226 = circuit_add(t225, t225);
    let t227 = circuit_sub(t224, in67);
    let t228 = circuit_mul(in50, t227);
    let t229 = circuit_sub(t226, t228);
    let t230 = circuit_add(t224, in67);
    let t231 = circuit_inverse(t230);
    let t232 = circuit_mul(t229, t231);
    let t233 = circuit_sub(in1, in66);
    let t234 = circuit_mul(t6, t233);
    let t235 = circuit_mul(t6, t232);
    let t236 = circuit_add(t235, t235);
    let t237 = circuit_sub(t234, in66);
    let t238 = circuit_mul(in49, t237);
    let t239 = circuit_sub(t236, t238);
    let t240 = circuit_add(t234, in66);
    let t241 = circuit_inverse(t240);
    let t242 = circuit_mul(t239, t241);
    let t243 = circuit_sub(in1, in65);
    let t244 = circuit_mul(t5, t243);
    let t245 = circuit_mul(t5, t242);
    let t246 = circuit_add(t245, t245);
    let t247 = circuit_sub(t244, in65);
    let t248 = circuit_mul(in48, t247);
    let t249 = circuit_sub(t246, t248);
    let t250 = circuit_add(t244, in65);
    let t251 = circuit_inverse(t250);
    let t252 = circuit_mul(t249, t251);
    let t253 = circuit_sub(in1, in64);
    let t254 = circuit_mul(t4, t253);
    let t255 = circuit_mul(t4, t252);
    let t256 = circuit_add(t255, t255);
    let t257 = circuit_sub(t254, in64);
    let t258 = circuit_mul(in47, t257);
    let t259 = circuit_sub(t256, t258);
    let t260 = circuit_add(t254, in64);
    let t261 = circuit_inverse(t260);
    let t262 = circuit_mul(t259, t261);
    let t263 = circuit_sub(in1, in63);
    let t264 = circuit_mul(t3, t263);
    let t265 = circuit_mul(t3, t262);
    let t266 = circuit_add(t265, t265);
    let t267 = circuit_sub(t264, in63);
    let t268 = circuit_mul(in46, t267);
    let t269 = circuit_sub(t266, t268);
    let t270 = circuit_add(t264, in63);
    let t271 = circuit_inverse(t270);
    let t272 = circuit_mul(t269, t271);
    let t273 = circuit_sub(in1, in62);
    let t274 = circuit_mul(t2, t273);
    let t275 = circuit_mul(t2, t272);
    let t276 = circuit_add(t275, t275);
    let t277 = circuit_sub(t274, in62);
    let t278 = circuit_mul(in45, t277);
    let t279 = circuit_sub(t276, t278);
    let t280 = circuit_add(t274, in62);
    let t281 = circuit_inverse(t280);
    let t282 = circuit_mul(t279, t281);
    let t283 = circuit_sub(in1, in61);
    let t284 = circuit_mul(t1, t283);
    let t285 = circuit_mul(t1, t282);
    let t286 = circuit_add(t285, t285);
    let t287 = circuit_sub(t284, in61);
    let t288 = circuit_mul(in44, t287);
    let t289 = circuit_sub(t286, t288);
    let t290 = circuit_add(t284, in61);
    let t291 = circuit_inverse(t290);
    let t292 = circuit_mul(t289, t291);
    let t293 = circuit_sub(in1, in60);
    let t294 = circuit_mul(t0, t293);
    let t295 = circuit_mul(t0, t292);
    let t296 = circuit_add(t295, t295);
    let t297 = circuit_sub(t294, in60);
    let t298 = circuit_mul(in43, t297);
    let t299 = circuit_sub(t296, t298);
    let t300 = circuit_add(t294, in60);
    let t301 = circuit_inverse(t300);
    let t302 = circuit_mul(t299, t301);
    let t303 = circuit_sub(in1, in59);
    let t304 = circuit_mul(in55, t303);
    let t305 = circuit_mul(in55, t302);
    let t306 = circuit_add(t305, t305);
    let t307 = circuit_sub(t304, in59);
    let t308 = circuit_mul(in42, t307);
    let t309 = circuit_sub(t306, t308);
    let t310 = circuit_add(t304, in59);
    let t311 = circuit_inverse(t310);
    let t312 = circuit_mul(t309, t311);
    let t313 = circuit_mul(t312, t13);
    let t314 = circuit_mul(in42, in58);
    let t315 = circuit_mul(t314, t15);
    let t316 = circuit_add(t313, t315);
    let t317 = circuit_mul(in58, in58);
    let t318 = circuit_sub(in57, t0);
    let t319 = circuit_inverse(t318);
    let t320 = circuit_add(in57, t0);
    let t321 = circuit_inverse(t320);
    let t322 = circuit_mul(t317, t319);
    let t323 = circuit_mul(in58, t321);
    let t324 = circuit_mul(t317, t323);
    let t325 = circuit_add(t324, t322);
    let t326 = circuit_sub(in0, t325);
    let t327 = circuit_mul(t324, in43);
    let t328 = circuit_mul(t322, t302);
    let t329 = circuit_add(t327, t328);
    let t330 = circuit_add(t316, t329);
    let t331 = circuit_mul(in58, in58);
    let t332 = circuit_mul(t317, t331);
    let t333 = circuit_sub(in57, t1);
    let t334 = circuit_inverse(t333);
    let t335 = circuit_add(in57, t1);
    let t336 = circuit_inverse(t335);
    let t337 = circuit_mul(t332, t334);
    let t338 = circuit_mul(in58, t336);
    let t339 = circuit_mul(t332, t338);
    let t340 = circuit_add(t339, t337);
    let t341 = circuit_sub(in0, t340);
    let t342 = circuit_mul(t339, in44);
    let t343 = circuit_mul(t337, t292);
    let t344 = circuit_add(t342, t343);
    let t345 = circuit_add(t330, t344);
    let t346 = circuit_mul(in58, in58);
    let t347 = circuit_mul(t332, t346);
    let t348 = circuit_sub(in57, t2);
    let t349 = circuit_inverse(t348);
    let t350 = circuit_add(in57, t2);
    let t351 = circuit_inverse(t350);
    let t352 = circuit_mul(t347, t349);
    let t353 = circuit_mul(in58, t351);
    let t354 = circuit_mul(t347, t353);
    let t355 = circuit_add(t354, t352);
    let t356 = circuit_sub(in0, t355);
    let t357 = circuit_mul(t354, in45);
    let t358 = circuit_mul(t352, t282);
    let t359 = circuit_add(t357, t358);
    let t360 = circuit_add(t345, t359);
    let t361 = circuit_mul(in58, in58);
    let t362 = circuit_mul(t347, t361);
    let t363 = circuit_sub(in57, t3);
    let t364 = circuit_inverse(t363);
    let t365 = circuit_add(in57, t3);
    let t366 = circuit_inverse(t365);
    let t367 = circuit_mul(t362, t364);
    let t368 = circuit_mul(in58, t366);
    let t369 = circuit_mul(t362, t368);
    let t370 = circuit_add(t369, t367);
    let t371 = circuit_sub(in0, t370);
    let t372 = circuit_mul(t369, in46);
    let t373 = circuit_mul(t367, t272);
    let t374 = circuit_add(t372, t373);
    let t375 = circuit_add(t360, t374);
    let t376 = circuit_mul(in58, in58);
    let t377 = circuit_mul(t362, t376);
    let t378 = circuit_sub(in57, t4);
    let t379 = circuit_inverse(t378);
    let t380 = circuit_add(in57, t4);
    let t381 = circuit_inverse(t380);
    let t382 = circuit_mul(t377, t379);
    let t383 = circuit_mul(in58, t381);
    let t384 = circuit_mul(t377, t383);
    let t385 = circuit_add(t384, t382);
    let t386 = circuit_sub(in0, t385);
    let t387 = circuit_mul(t384, in47);
    let t388 = circuit_mul(t382, t262);
    let t389 = circuit_add(t387, t388);
    let t390 = circuit_add(t375, t389);
    let t391 = circuit_mul(in58, in58);
    let t392 = circuit_mul(t377, t391);
    let t393 = circuit_sub(in57, t5);
    let t394 = circuit_inverse(t393);
    let t395 = circuit_add(in57, t5);
    let t396 = circuit_inverse(t395);
    let t397 = circuit_mul(t392, t394);
    let t398 = circuit_mul(in58, t396);
    let t399 = circuit_mul(t392, t398);
    let t400 = circuit_add(t399, t397);
    let t401 = circuit_sub(in0, t400);
    let t402 = circuit_mul(t399, in48);
    let t403 = circuit_mul(t397, t252);
    let t404 = circuit_add(t402, t403);
    let t405 = circuit_add(t390, t404);
    let t406 = circuit_mul(in58, in58);
    let t407 = circuit_mul(t392, t406);
    let t408 = circuit_sub(in57, t6);
    let t409 = circuit_inverse(t408);
    let t410 = circuit_add(in57, t6);
    let t411 = circuit_inverse(t410);
    let t412 = circuit_mul(t407, t409);
    let t413 = circuit_mul(in58, t411);
    let t414 = circuit_mul(t407, t413);
    let t415 = circuit_add(t414, t412);
    let t416 = circuit_sub(in0, t415);
    let t417 = circuit_mul(t414, in49);
    let t418 = circuit_mul(t412, t242);
    let t419 = circuit_add(t417, t418);
    let t420 = circuit_add(t405, t419);
    let t421 = circuit_mul(in58, in58);
    let t422 = circuit_mul(t407, t421);
    let t423 = circuit_sub(in57, t7);
    let t424 = circuit_inverse(t423);
    let t425 = circuit_add(in57, t7);
    let t426 = circuit_inverse(t425);
    let t427 = circuit_mul(t422, t424);
    let t428 = circuit_mul(in58, t426);
    let t429 = circuit_mul(t422, t428);
    let t430 = circuit_add(t429, t427);
    let t431 = circuit_sub(in0, t430);
    let t432 = circuit_mul(t429, in50);
    let t433 = circuit_mul(t427, t232);
    let t434 = circuit_add(t432, t433);
    let t435 = circuit_add(t420, t434);
    let t436 = circuit_mul(in58, in58);
    let t437 = circuit_mul(t422, t436);
    let t438 = circuit_sub(in57, t8);
    let t439 = circuit_inverse(t438);
    let t440 = circuit_add(in57, t8);
    let t441 = circuit_inverse(t440);
    let t442 = circuit_mul(t437, t439);
    let t443 = circuit_mul(in58, t441);
    let t444 = circuit_mul(t437, t443);
    let t445 = circuit_add(t444, t442);
    let t446 = circuit_sub(in0, t445);
    let t447 = circuit_mul(t444, in51);
    let t448 = circuit_mul(t442, t222);
    let t449 = circuit_add(t447, t448);
    let t450 = circuit_add(t435, t449);
    let t451 = circuit_mul(in58, in58);
    let t452 = circuit_mul(t437, t451);
    let t453 = circuit_sub(in57, t9);
    let t454 = circuit_inverse(t453);
    let t455 = circuit_add(in57, t9);
    let t456 = circuit_inverse(t455);
    let t457 = circuit_mul(t452, t454);
    let t458 = circuit_mul(in58, t456);
    let t459 = circuit_mul(t452, t458);
    let t460 = circuit_add(t459, t457);
    let t461 = circuit_sub(in0, t460);
    let t462 = circuit_mul(t459, in52);
    let t463 = circuit_mul(t457, t212);
    let t464 = circuit_add(t462, t463);
    let t465 = circuit_add(t450, t464);
    let t466 = circuit_mul(in58, in58);
    let t467 = circuit_mul(t452, t466);
    let t468 = circuit_sub(in57, t10);
    let t469 = circuit_inverse(t468);
    let t470 = circuit_add(in57, t10);
    let t471 = circuit_inverse(t470);
    let t472 = circuit_mul(t467, t469);
    let t473 = circuit_mul(in58, t471);
    let t474 = circuit_mul(t467, t473);
    let t475 = circuit_add(t474, t472);
    let t476 = circuit_sub(in0, t475);
    let t477 = circuit_mul(t474, in53);
    let t478 = circuit_mul(t472, t202);
    let t479 = circuit_add(t477, t478);
    let t480 = circuit_add(t465, t479);
    let t481 = circuit_mul(in58, in58);
    let t482 = circuit_mul(t467, t481);
    let t483 = circuit_sub(in57, t11);
    let t484 = circuit_inverse(t483);
    let t485 = circuit_add(in57, t11);
    let t486 = circuit_inverse(t485);
    let t487 = circuit_mul(t482, t484);
    let t488 = circuit_mul(in58, t486);
    let t489 = circuit_mul(t482, t488);
    let t490 = circuit_add(t489, t487);
    let t491 = circuit_sub(in0, t490);
    let t492 = circuit_mul(t489, in54);
    let t493 = circuit_mul(t487, t192);
    let t494 = circuit_add(t492, t493);
    let t495 = circuit_add(t480, t494);
    let t496 = circuit_add(t132, t164);
    let t497 = circuit_add(t136, t168);
    let t498 = circuit_add(t140, t172);
    let t499 = circuit_add(t144, t176);
    let t500 = circuit_add(t148, t180);

    let modulus = modulus;

    let mut circuit_inputs = (
        t24,
        t28,
        t32,
        t36,
        t40,
        t44,
        t48,
        t52,
        t56,
        t60,
        t64,
        t68,
        t72,
        t76,
        t80,
        t84,
        t88,
        t92,
        t96,
        t100,
        t104,
        t108,
        t112,
        t116,
        t120,
        t124,
        t128,
        t496,
        t497,
        t498,
        t499,
        t500,
        t152,
        t156,
        t160,
        t326,
        t341,
        t356,
        t371,
        t386,
        t401,
        t416,
        t431,
        t446,
        t461,
        t476,
        t491,
        t495,
    )
        .new_inputs();
    // Prefill constants:
    circuit_inputs = circuit_inputs.next_2([0x0, 0x0, 0x0, 0x0]); // in0
    circuit_inputs = circuit_inputs.next_2([0x1, 0x0, 0x0, 0x0]); // in1
    // Fill inputs:

    for val in p_sumcheck_evaluations {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in2 - in41

    for val in p_gemini_a_evaluations {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in42 - in54

    circuit_inputs = circuit_inputs.next_2(tp_gemini_r); // in55
    circuit_inputs = circuit_inputs.next_2(tp_rho); // in56
    circuit_inputs = circuit_inputs.next_2(tp_shplonk_z); // in57
    circuit_inputs = circuit_inputs.next_2(tp_shplonk_nu); // in58

    for val in tp_sum_check_u_challenges {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in59 - in71

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let scalar_1: u384 = outputs.get_output(t24);
    let scalar_2: u384 = outputs.get_output(t28);
    let scalar_3: u384 = outputs.get_output(t32);
    let scalar_4: u384 = outputs.get_output(t36);
    let scalar_5: u384 = outputs.get_output(t40);
    let scalar_6: u384 = outputs.get_output(t44);
    let scalar_7: u384 = outputs.get_output(t48);
    let scalar_8: u384 = outputs.get_output(t52);
    let scalar_9: u384 = outputs.get_output(t56);
    let scalar_10: u384 = outputs.get_output(t60);
    let scalar_11: u384 = outputs.get_output(t64);
    let scalar_12: u384 = outputs.get_output(t68);
    let scalar_13: u384 = outputs.get_output(t72);
    let scalar_14: u384 = outputs.get_output(t76);
    let scalar_15: u384 = outputs.get_output(t80);
    let scalar_16: u384 = outputs.get_output(t84);
    let scalar_17: u384 = outputs.get_output(t88);
    let scalar_18: u384 = outputs.get_output(t92);
    let scalar_19: u384 = outputs.get_output(t96);
    let scalar_20: u384 = outputs.get_output(t100);
    let scalar_21: u384 = outputs.get_output(t104);
    let scalar_22: u384 = outputs.get_output(t108);
    let scalar_23: u384 = outputs.get_output(t112);
    let scalar_24: u384 = outputs.get_output(t116);
    let scalar_25: u384 = outputs.get_output(t120);
    let scalar_26: u384 = outputs.get_output(t124);
    let scalar_27: u384 = outputs.get_output(t128);
    let scalar_28: u384 = outputs.get_output(t496);
    let scalar_29: u384 = outputs.get_output(t497);
    let scalar_30: u384 = outputs.get_output(t498);
    let scalar_31: u384 = outputs.get_output(t499);
    let scalar_32: u384 = outputs.get_output(t500);
    let scalar_33: u384 = outputs.get_output(t152);
    let scalar_34: u384 = outputs.get_output(t156);
    let scalar_35: u384 = outputs.get_output(t160);
    let scalar_41: u384 = outputs.get_output(t326);
    let scalar_42: u384 = outputs.get_output(t341);
    let scalar_43: u384 = outputs.get_output(t356);
    let scalar_44: u384 = outputs.get_output(t371);
    let scalar_45: u384 = outputs.get_output(t386);
    let scalar_46: u384 = outputs.get_output(t401);
    let scalar_47: u384 = outputs.get_output(t416);
    let scalar_48: u384 = outputs.get_output(t431);
    let scalar_49: u384 = outputs.get_output(t446);
    let scalar_50: u384 = outputs.get_output(t461);
    let scalar_51: u384 = outputs.get_output(t476);
    let scalar_52: u384 = outputs.get_output(t491);
    let scalar_68: u384 = outputs.get_output(t495);
    return (
        scalar_1,
        scalar_2,
        scalar_3,
        scalar_4,
        scalar_5,
        scalar_6,
        scalar_7,
        scalar_8,
        scalar_9,
        scalar_10,
        scalar_11,
        scalar_12,
        scalar_13,
        scalar_14,
        scalar_15,
        scalar_16,
        scalar_17,
        scalar_18,
        scalar_19,
        scalar_20,
        scalar_21,
        scalar_22,
        scalar_23,
        scalar_24,
        scalar_25,
        scalar_26,
        scalar_27,
        scalar_28,
        scalar_29,
        scalar_30,
        scalar_31,
        scalar_32,
        scalar_33,
        scalar_34,
        scalar_35,
        scalar_41,
        scalar_42,
        scalar_43,
        scalar_44,
        scalar_45,
        scalar_46,
        scalar_47,
        scalar_48,
        scalar_49,
        scalar_50,
        scalar_51,
        scalar_52,
        scalar_68,
    );
}
pub fn run_BN254_EVAL_FN_CHALLENGE_SING_49P_RLC_circuit<
    T, +IntoCircuitInputValue<T>, +Drop<T>, +Copy<T>,
>(
    A: G1Point, coeff: u384, SumDlogDivBatched: FunctionFelt<T>, modulus: CircuitModulus,
) -> (u384,) {
    // INPUT stack
    let (in0, in1, in2) = (CE::<CI<0>> {}, CE::<CI<1>> {}, CE::<CI<2>> {});
    let (in3, in4, in5) = (CE::<CI<3>> {}, CE::<CI<4>> {}, CE::<CI<5>> {});
    let (in6, in7, in8) = (CE::<CI<6>> {}, CE::<CI<7>> {}, CE::<CI<8>> {});
    let (in9, in10, in11) = (CE::<CI<9>> {}, CE::<CI<10>> {}, CE::<CI<11>> {});
    let (in12, in13, in14) = (CE::<CI<12>> {}, CE::<CI<13>> {}, CE::<CI<14>> {});
    let (in15, in16, in17) = (CE::<CI<15>> {}, CE::<CI<16>> {}, CE::<CI<17>> {});
    let (in18, in19, in20) = (CE::<CI<18>> {}, CE::<CI<19>> {}, CE::<CI<20>> {});
    let (in21, in22, in23) = (CE::<CI<21>> {}, CE::<CI<22>> {}, CE::<CI<23>> {});
    let (in24, in25, in26) = (CE::<CI<24>> {}, CE::<CI<25>> {}, CE::<CI<26>> {});
    let (in27, in28, in29) = (CE::<CI<27>> {}, CE::<CI<28>> {}, CE::<CI<29>> {});
    let (in30, in31, in32) = (CE::<CI<30>> {}, CE::<CI<31>> {}, CE::<CI<32>> {});
    let (in33, in34, in35) = (CE::<CI<33>> {}, CE::<CI<34>> {}, CE::<CI<35>> {});
    let (in36, in37, in38) = (CE::<CI<36>> {}, CE::<CI<37>> {}, CE::<CI<38>> {});
    let (in39, in40, in41) = (CE::<CI<39>> {}, CE::<CI<40>> {}, CE::<CI<41>> {});
    let (in42, in43, in44) = (CE::<CI<42>> {}, CE::<CI<43>> {}, CE::<CI<44>> {});
    let (in45, in46, in47) = (CE::<CI<45>> {}, CE::<CI<46>> {}, CE::<CI<47>> {});
    let (in48, in49, in50) = (CE::<CI<48>> {}, CE::<CI<49>> {}, CE::<CI<50>> {});
    let (in51, in52, in53) = (CE::<CI<51>> {}, CE::<CI<52>> {}, CE::<CI<53>> {});
    let (in54, in55, in56) = (CE::<CI<54>> {}, CE::<CI<55>> {}, CE::<CI<56>> {});
    let (in57, in58, in59) = (CE::<CI<57>> {}, CE::<CI<58>> {}, CE::<CI<59>> {});
    let (in60, in61, in62) = (CE::<CI<60>> {}, CE::<CI<61>> {}, CE::<CI<62>> {});
    let (in63, in64, in65) = (CE::<CI<63>> {}, CE::<CI<64>> {}, CE::<CI<65>> {});
    let (in66, in67, in68) = (CE::<CI<66>> {}, CE::<CI<67>> {}, CE::<CI<68>> {});
    let (in69, in70, in71) = (CE::<CI<69>> {}, CE::<CI<70>> {}, CE::<CI<71>> {});
    let (in72, in73, in74) = (CE::<CI<72>> {}, CE::<CI<73>> {}, CE::<CI<74>> {});
    let (in75, in76, in77) = (CE::<CI<75>> {}, CE::<CI<76>> {}, CE::<CI<77>> {});
    let (in78, in79, in80) = (CE::<CI<78>> {}, CE::<CI<79>> {}, CE::<CI<80>> {});
    let (in81, in82, in83) = (CE::<CI<81>> {}, CE::<CI<82>> {}, CE::<CI<83>> {});
    let (in84, in85, in86) = (CE::<CI<84>> {}, CE::<CI<85>> {}, CE::<CI<86>> {});
    let (in87, in88, in89) = (CE::<CI<87>> {}, CE::<CI<88>> {}, CE::<CI<89>> {});
    let (in90, in91, in92) = (CE::<CI<90>> {}, CE::<CI<91>> {}, CE::<CI<92>> {});
    let (in93, in94, in95) = (CE::<CI<93>> {}, CE::<CI<94>> {}, CE::<CI<95>> {});
    let (in96, in97, in98) = (CE::<CI<96>> {}, CE::<CI<97>> {}, CE::<CI<98>> {});
    let (in99, in100, in101) = (CE::<CI<99>> {}, CE::<CI<100>> {}, CE::<CI<101>> {});
    let (in102, in103, in104) = (CE::<CI<102>> {}, CE::<CI<103>> {}, CE::<CI<104>> {});
    let (in105, in106, in107) = (CE::<CI<105>> {}, CE::<CI<106>> {}, CE::<CI<107>> {});
    let (in108, in109, in110) = (CE::<CI<108>> {}, CE::<CI<109>> {}, CE::<CI<110>> {});
    let (in111, in112, in113) = (CE::<CI<111>> {}, CE::<CI<112>> {}, CE::<CI<113>> {});
    let (in114, in115, in116) = (CE::<CI<114>> {}, CE::<CI<115>> {}, CE::<CI<116>> {});
    let (in117, in118, in119) = (CE::<CI<117>> {}, CE::<CI<118>> {}, CE::<CI<119>> {});
    let (in120, in121, in122) = (CE::<CI<120>> {}, CE::<CI<121>> {}, CE::<CI<122>> {});
    let (in123, in124, in125) = (CE::<CI<123>> {}, CE::<CI<124>> {}, CE::<CI<125>> {});
    let (in126, in127, in128) = (CE::<CI<126>> {}, CE::<CI<127>> {}, CE::<CI<128>> {});
    let (in129, in130, in131) = (CE::<CI<129>> {}, CE::<CI<130>> {}, CE::<CI<131>> {});
    let (in132, in133, in134) = (CE::<CI<132>> {}, CE::<CI<133>> {}, CE::<CI<134>> {});
    let (in135, in136, in137) = (CE::<CI<135>> {}, CE::<CI<136>> {}, CE::<CI<137>> {});
    let (in138, in139, in140) = (CE::<CI<138>> {}, CE::<CI<139>> {}, CE::<CI<140>> {});
    let (in141, in142, in143) = (CE::<CI<141>> {}, CE::<CI<142>> {}, CE::<CI<143>> {});
    let (in144, in145, in146) = (CE::<CI<144>> {}, CE::<CI<145>> {}, CE::<CI<146>> {});
    let (in147, in148, in149) = (CE::<CI<147>> {}, CE::<CI<148>> {}, CE::<CI<149>> {});
    let (in150, in151, in152) = (CE::<CI<150>> {}, CE::<CI<151>> {}, CE::<CI<152>> {});
    let (in153, in154, in155) = (CE::<CI<153>> {}, CE::<CI<154>> {}, CE::<CI<155>> {});
    let (in156, in157, in158) = (CE::<CI<156>> {}, CE::<CI<157>> {}, CE::<CI<158>> {});
    let (in159, in160, in161) = (CE::<CI<159>> {}, CE::<CI<160>> {}, CE::<CI<161>> {});
    let (in162, in163, in164) = (CE::<CI<162>> {}, CE::<CI<163>> {}, CE::<CI<164>> {});
    let (in165, in166, in167) = (CE::<CI<165>> {}, CE::<CI<166>> {}, CE::<CI<167>> {});
    let (in168, in169, in170) = (CE::<CI<168>> {}, CE::<CI<169>> {}, CE::<CI<170>> {});
    let (in171, in172, in173) = (CE::<CI<171>> {}, CE::<CI<172>> {}, CE::<CI<173>> {});
    let (in174, in175, in176) = (CE::<CI<174>> {}, CE::<CI<175>> {}, CE::<CI<176>> {});
    let (in177, in178, in179) = (CE::<CI<177>> {}, CE::<CI<178>> {}, CE::<CI<179>> {});
    let (in180, in181, in182) = (CE::<CI<180>> {}, CE::<CI<181>> {}, CE::<CI<182>> {});
    let (in183, in184, in185) = (CE::<CI<183>> {}, CE::<CI<184>> {}, CE::<CI<185>> {});
    let (in186, in187, in188) = (CE::<CI<186>> {}, CE::<CI<187>> {}, CE::<CI<188>> {});
    let (in189, in190, in191) = (CE::<CI<189>> {}, CE::<CI<190>> {}, CE::<CI<191>> {});
    let (in192, in193, in194) = (CE::<CI<192>> {}, CE::<CI<193>> {}, CE::<CI<194>> {});
    let (in195, in196, in197) = (CE::<CI<195>> {}, CE::<CI<196>> {}, CE::<CI<197>> {});
    let (in198, in199, in200) = (CE::<CI<198>> {}, CE::<CI<199>> {}, CE::<CI<200>> {});
    let (in201, in202, in203) = (CE::<CI<201>> {}, CE::<CI<202>> {}, CE::<CI<203>> {});
    let (in204, in205, in206) = (CE::<CI<204>> {}, CE::<CI<205>> {}, CE::<CI<206>> {});
    let (in207, in208, in209) = (CE::<CI<207>> {}, CE::<CI<208>> {}, CE::<CI<209>> {});
    let (in210, in211, in212) = (CE::<CI<210>> {}, CE::<CI<211>> {}, CE::<CI<212>> {});
    let (in213, in214, in215) = (CE::<CI<213>> {}, CE::<CI<214>> {}, CE::<CI<215>> {});
    let in216 = CE::<CI<216>> {};
    let t0 = circuit_mul(in54, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t1 = circuit_add(in53, t0); // Eval sumdlogdiv_a_num Horner step: add coefficient_50
    let t2 = circuit_mul(t1, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t3 = circuit_add(in52, t2); // Eval sumdlogdiv_a_num Horner step: add coefficient_49
    let t4 = circuit_mul(t3, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t5 = circuit_add(in51, t4); // Eval sumdlogdiv_a_num Horner step: add coefficient_48
    let t6 = circuit_mul(t5, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t7 = circuit_add(in50, t6); // Eval sumdlogdiv_a_num Horner step: add coefficient_47
    let t8 = circuit_mul(t7, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t9 = circuit_add(in49, t8); // Eval sumdlogdiv_a_num Horner step: add coefficient_46
    let t10 = circuit_mul(t9, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t11 = circuit_add(in48, t10); // Eval sumdlogdiv_a_num Horner step: add coefficient_45
    let t12 = circuit_mul(t11, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t13 = circuit_add(in47, t12); // Eval sumdlogdiv_a_num Horner step: add coefficient_44
    let t14 = circuit_mul(t13, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t15 = circuit_add(in46, t14); // Eval sumdlogdiv_a_num Horner step: add coefficient_43
    let t16 = circuit_mul(t15, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t17 = circuit_add(in45, t16); // Eval sumdlogdiv_a_num Horner step: add coefficient_42
    let t18 = circuit_mul(t17, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t19 = circuit_add(in44, t18); // Eval sumdlogdiv_a_num Horner step: add coefficient_41
    let t20 = circuit_mul(t19, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t21 = circuit_add(in43, t20); // Eval sumdlogdiv_a_num Horner step: add coefficient_40
    let t22 = circuit_mul(t21, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t23 = circuit_add(in42, t22); // Eval sumdlogdiv_a_num Horner step: add coefficient_39
    let t24 = circuit_mul(t23, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t25 = circuit_add(in41, t24); // Eval sumdlogdiv_a_num Horner step: add coefficient_38
    let t26 = circuit_mul(t25, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t27 = circuit_add(in40, t26); // Eval sumdlogdiv_a_num Horner step: add coefficient_37
    let t28 = circuit_mul(t27, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t29 = circuit_add(in39, t28); // Eval sumdlogdiv_a_num Horner step: add coefficient_36
    let t30 = circuit_mul(t29, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t31 = circuit_add(in38, t30); // Eval sumdlogdiv_a_num Horner step: add coefficient_35
    let t32 = circuit_mul(t31, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t33 = circuit_add(in37, t32); // Eval sumdlogdiv_a_num Horner step: add coefficient_34
    let t34 = circuit_mul(t33, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t35 = circuit_add(in36, t34); // Eval sumdlogdiv_a_num Horner step: add coefficient_33
    let t36 = circuit_mul(t35, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t37 = circuit_add(in35, t36); // Eval sumdlogdiv_a_num Horner step: add coefficient_32
    let t38 = circuit_mul(t37, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t39 = circuit_add(in34, t38); // Eval sumdlogdiv_a_num Horner step: add coefficient_31
    let t40 = circuit_mul(t39, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t41 = circuit_add(in33, t40); // Eval sumdlogdiv_a_num Horner step: add coefficient_30
    let t42 = circuit_mul(t41, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t43 = circuit_add(in32, t42); // Eval sumdlogdiv_a_num Horner step: add coefficient_29
    let t44 = circuit_mul(t43, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t45 = circuit_add(in31, t44); // Eval sumdlogdiv_a_num Horner step: add coefficient_28
    let t46 = circuit_mul(t45, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t47 = circuit_add(in30, t46); // Eval sumdlogdiv_a_num Horner step: add coefficient_27
    let t48 = circuit_mul(t47, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t49 = circuit_add(in29, t48); // Eval sumdlogdiv_a_num Horner step: add coefficient_26
    let t50 = circuit_mul(t49, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t51 = circuit_add(in28, t50); // Eval sumdlogdiv_a_num Horner step: add coefficient_25
    let t52 = circuit_mul(t51, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t53 = circuit_add(in27, t52); // Eval sumdlogdiv_a_num Horner step: add coefficient_24
    let t54 = circuit_mul(t53, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t55 = circuit_add(in26, t54); // Eval sumdlogdiv_a_num Horner step: add coefficient_23
    let t56 = circuit_mul(t55, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t57 = circuit_add(in25, t56); // Eval sumdlogdiv_a_num Horner step: add coefficient_22
    let t58 = circuit_mul(t57, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t59 = circuit_add(in24, t58); // Eval sumdlogdiv_a_num Horner step: add coefficient_21
    let t60 = circuit_mul(t59, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t61 = circuit_add(in23, t60); // Eval sumdlogdiv_a_num Horner step: add coefficient_20
    let t62 = circuit_mul(t61, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t63 = circuit_add(in22, t62); // Eval sumdlogdiv_a_num Horner step: add coefficient_19
    let t64 = circuit_mul(t63, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t65 = circuit_add(in21, t64); // Eval sumdlogdiv_a_num Horner step: add coefficient_18
    let t66 = circuit_mul(t65, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t67 = circuit_add(in20, t66); // Eval sumdlogdiv_a_num Horner step: add coefficient_17
    let t68 = circuit_mul(t67, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t69 = circuit_add(in19, t68); // Eval sumdlogdiv_a_num Horner step: add coefficient_16
    let t70 = circuit_mul(t69, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t71 = circuit_add(in18, t70); // Eval sumdlogdiv_a_num Horner step: add coefficient_15
    let t72 = circuit_mul(t71, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t73 = circuit_add(in17, t72); // Eval sumdlogdiv_a_num Horner step: add coefficient_14
    let t74 = circuit_mul(t73, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t75 = circuit_add(in16, t74); // Eval sumdlogdiv_a_num Horner step: add coefficient_13
    let t76 = circuit_mul(t75, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t77 = circuit_add(in15, t76); // Eval sumdlogdiv_a_num Horner step: add coefficient_12
    let t78 = circuit_mul(t77, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t79 = circuit_add(in14, t78); // Eval sumdlogdiv_a_num Horner step: add coefficient_11
    let t80 = circuit_mul(t79, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t81 = circuit_add(in13, t80); // Eval sumdlogdiv_a_num Horner step: add coefficient_10
    let t82 = circuit_mul(t81, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t83 = circuit_add(in12, t82); // Eval sumdlogdiv_a_num Horner step: add coefficient_9
    let t84 = circuit_mul(t83, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t85 = circuit_add(in11, t84); // Eval sumdlogdiv_a_num Horner step: add coefficient_8
    let t86 = circuit_mul(t85, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t87 = circuit_add(in10, t86); // Eval sumdlogdiv_a_num Horner step: add coefficient_7
    let t88 = circuit_mul(t87, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t89 = circuit_add(in9, t88); // Eval sumdlogdiv_a_num Horner step: add coefficient_6
    let t90 = circuit_mul(t89, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t91 = circuit_add(in8, t90); // Eval sumdlogdiv_a_num Horner step: add coefficient_5
    let t92 = circuit_mul(t91, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t93 = circuit_add(in7, t92); // Eval sumdlogdiv_a_num Horner step: add coefficient_4
    let t94 = circuit_mul(t93, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t95 = circuit_add(in6, t94); // Eval sumdlogdiv_a_num Horner step: add coefficient_3
    let t96 = circuit_mul(t95, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t97 = circuit_add(in5, t96); // Eval sumdlogdiv_a_num Horner step: add coefficient_2
    let t98 = circuit_mul(t97, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t99 = circuit_add(in4, t98); // Eval sumdlogdiv_a_num Horner step: add coefficient_1
    let t100 = circuit_mul(t99, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t101 = circuit_add(in3, t100); // Eval sumdlogdiv_a_num Horner step: add coefficient_0
    let t102 = circuit_mul(in107, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t103 = circuit_add(in106, t102); // Eval sumdlogdiv_a_den Horner step: add coefficient_51
    let t104 = circuit_mul(t103, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t105 = circuit_add(in105, t104); // Eval sumdlogdiv_a_den Horner step: add coefficient_50
    let t106 = circuit_mul(t105, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t107 = circuit_add(in104, t106); // Eval sumdlogdiv_a_den Horner step: add coefficient_49
    let t108 = circuit_mul(t107, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t109 = circuit_add(in103, t108); // Eval sumdlogdiv_a_den Horner step: add coefficient_48
    let t110 = circuit_mul(t109, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t111 = circuit_add(in102, t110); // Eval sumdlogdiv_a_den Horner step: add coefficient_47
    let t112 = circuit_mul(t111, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t113 = circuit_add(in101, t112); // Eval sumdlogdiv_a_den Horner step: add coefficient_46
    let t114 = circuit_mul(t113, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t115 = circuit_add(in100, t114); // Eval sumdlogdiv_a_den Horner step: add coefficient_45
    let t116 = circuit_mul(t115, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t117 = circuit_add(in99, t116); // Eval sumdlogdiv_a_den Horner step: add coefficient_44
    let t118 = circuit_mul(t117, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t119 = circuit_add(in98, t118); // Eval sumdlogdiv_a_den Horner step: add coefficient_43
    let t120 = circuit_mul(t119, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t121 = circuit_add(in97, t120); // Eval sumdlogdiv_a_den Horner step: add coefficient_42
    let t122 = circuit_mul(t121, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t123 = circuit_add(in96, t122); // Eval sumdlogdiv_a_den Horner step: add coefficient_41
    let t124 = circuit_mul(t123, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t125 = circuit_add(in95, t124); // Eval sumdlogdiv_a_den Horner step: add coefficient_40
    let t126 = circuit_mul(t125, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t127 = circuit_add(in94, t126); // Eval sumdlogdiv_a_den Horner step: add coefficient_39
    let t128 = circuit_mul(t127, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t129 = circuit_add(in93, t128); // Eval sumdlogdiv_a_den Horner step: add coefficient_38
    let t130 = circuit_mul(t129, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t131 = circuit_add(in92, t130); // Eval sumdlogdiv_a_den Horner step: add coefficient_37
    let t132 = circuit_mul(t131, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t133 = circuit_add(in91, t132); // Eval sumdlogdiv_a_den Horner step: add coefficient_36
    let t134 = circuit_mul(t133, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t135 = circuit_add(in90, t134); // Eval sumdlogdiv_a_den Horner step: add coefficient_35
    let t136 = circuit_mul(t135, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t137 = circuit_add(in89, t136); // Eval sumdlogdiv_a_den Horner step: add coefficient_34
    let t138 = circuit_mul(t137, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t139 = circuit_add(in88, t138); // Eval sumdlogdiv_a_den Horner step: add coefficient_33
    let t140 = circuit_mul(t139, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t141 = circuit_add(in87, t140); // Eval sumdlogdiv_a_den Horner step: add coefficient_32
    let t142 = circuit_mul(t141, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t143 = circuit_add(in86, t142); // Eval sumdlogdiv_a_den Horner step: add coefficient_31
    let t144 = circuit_mul(t143, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t145 = circuit_add(in85, t144); // Eval sumdlogdiv_a_den Horner step: add coefficient_30
    let t146 = circuit_mul(t145, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t147 = circuit_add(in84, t146); // Eval sumdlogdiv_a_den Horner step: add coefficient_29
    let t148 = circuit_mul(t147, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t149 = circuit_add(in83, t148); // Eval sumdlogdiv_a_den Horner step: add coefficient_28
    let t150 = circuit_mul(t149, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t151 = circuit_add(in82, t150); // Eval sumdlogdiv_a_den Horner step: add coefficient_27
    let t152 = circuit_mul(t151, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t153 = circuit_add(in81, t152); // Eval sumdlogdiv_a_den Horner step: add coefficient_26
    let t154 = circuit_mul(t153, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t155 = circuit_add(in80, t154); // Eval sumdlogdiv_a_den Horner step: add coefficient_25
    let t156 = circuit_mul(t155, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t157 = circuit_add(in79, t156); // Eval sumdlogdiv_a_den Horner step: add coefficient_24
    let t158 = circuit_mul(t157, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t159 = circuit_add(in78, t158); // Eval sumdlogdiv_a_den Horner step: add coefficient_23
    let t160 = circuit_mul(t159, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t161 = circuit_add(in77, t160); // Eval sumdlogdiv_a_den Horner step: add coefficient_22
    let t162 = circuit_mul(t161, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t163 = circuit_add(in76, t162); // Eval sumdlogdiv_a_den Horner step: add coefficient_21
    let t164 = circuit_mul(t163, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t165 = circuit_add(in75, t164); // Eval sumdlogdiv_a_den Horner step: add coefficient_20
    let t166 = circuit_mul(t165, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t167 = circuit_add(in74, t166); // Eval sumdlogdiv_a_den Horner step: add coefficient_19
    let t168 = circuit_mul(t167, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t169 = circuit_add(in73, t168); // Eval sumdlogdiv_a_den Horner step: add coefficient_18
    let t170 = circuit_mul(t169, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t171 = circuit_add(in72, t170); // Eval sumdlogdiv_a_den Horner step: add coefficient_17
    let t172 = circuit_mul(t171, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t173 = circuit_add(in71, t172); // Eval sumdlogdiv_a_den Horner step: add coefficient_16
    let t174 = circuit_mul(t173, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t175 = circuit_add(in70, t174); // Eval sumdlogdiv_a_den Horner step: add coefficient_15
    let t176 = circuit_mul(t175, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t177 = circuit_add(in69, t176); // Eval sumdlogdiv_a_den Horner step: add coefficient_14
    let t178 = circuit_mul(t177, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t179 = circuit_add(in68, t178); // Eval sumdlogdiv_a_den Horner step: add coefficient_13
    let t180 = circuit_mul(t179, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t181 = circuit_add(in67, t180); // Eval sumdlogdiv_a_den Horner step: add coefficient_12
    let t182 = circuit_mul(t181, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t183 = circuit_add(in66, t182); // Eval sumdlogdiv_a_den Horner step: add coefficient_11
    let t184 = circuit_mul(t183, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t185 = circuit_add(in65, t184); // Eval sumdlogdiv_a_den Horner step: add coefficient_10
    let t186 = circuit_mul(t185, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t187 = circuit_add(in64, t186); // Eval sumdlogdiv_a_den Horner step: add coefficient_9
    let t188 = circuit_mul(t187, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t189 = circuit_add(in63, t188); // Eval sumdlogdiv_a_den Horner step: add coefficient_8
    let t190 = circuit_mul(t189, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t191 = circuit_add(in62, t190); // Eval sumdlogdiv_a_den Horner step: add coefficient_7
    let t192 = circuit_mul(t191, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t193 = circuit_add(in61, t192); // Eval sumdlogdiv_a_den Horner step: add coefficient_6
    let t194 = circuit_mul(t193, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t195 = circuit_add(in60, t194); // Eval sumdlogdiv_a_den Horner step: add coefficient_5
    let t196 = circuit_mul(t195, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t197 = circuit_add(in59, t196); // Eval sumdlogdiv_a_den Horner step: add coefficient_4
    let t198 = circuit_mul(t197, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t199 = circuit_add(in58, t198); // Eval sumdlogdiv_a_den Horner step: add coefficient_3
    let t200 = circuit_mul(t199, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t201 = circuit_add(in57, t200); // Eval sumdlogdiv_a_den Horner step: add coefficient_2
    let t202 = circuit_mul(t201, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t203 = circuit_add(in56, t202); // Eval sumdlogdiv_a_den Horner step: add coefficient_1
    let t204 = circuit_mul(t203, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t205 = circuit_add(in55, t204); // Eval sumdlogdiv_a_den Horner step: add coefficient_0
    let t206 = circuit_inverse(t205);
    let t207 = circuit_mul(t101, t206);
    let t208 = circuit_mul(in160, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t209 = circuit_add(in159, t208); // Eval sumdlogdiv_b_num Horner step: add coefficient_51
    let t210 = circuit_mul(t209, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t211 = circuit_add(in158, t210); // Eval sumdlogdiv_b_num Horner step: add coefficient_50
    let t212 = circuit_mul(t211, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t213 = circuit_add(in157, t212); // Eval sumdlogdiv_b_num Horner step: add coefficient_49
    let t214 = circuit_mul(t213, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t215 = circuit_add(in156, t214); // Eval sumdlogdiv_b_num Horner step: add coefficient_48
    let t216 = circuit_mul(t215, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t217 = circuit_add(in155, t216); // Eval sumdlogdiv_b_num Horner step: add coefficient_47
    let t218 = circuit_mul(t217, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t219 = circuit_add(in154, t218); // Eval sumdlogdiv_b_num Horner step: add coefficient_46
    let t220 = circuit_mul(t219, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t221 = circuit_add(in153, t220); // Eval sumdlogdiv_b_num Horner step: add coefficient_45
    let t222 = circuit_mul(t221, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t223 = circuit_add(in152, t222); // Eval sumdlogdiv_b_num Horner step: add coefficient_44
    let t224 = circuit_mul(t223, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t225 = circuit_add(in151, t224); // Eval sumdlogdiv_b_num Horner step: add coefficient_43
    let t226 = circuit_mul(t225, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t227 = circuit_add(in150, t226); // Eval sumdlogdiv_b_num Horner step: add coefficient_42
    let t228 = circuit_mul(t227, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t229 = circuit_add(in149, t228); // Eval sumdlogdiv_b_num Horner step: add coefficient_41
    let t230 = circuit_mul(t229, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t231 = circuit_add(in148, t230); // Eval sumdlogdiv_b_num Horner step: add coefficient_40
    let t232 = circuit_mul(t231, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t233 = circuit_add(in147, t232); // Eval sumdlogdiv_b_num Horner step: add coefficient_39
    let t234 = circuit_mul(t233, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t235 = circuit_add(in146, t234); // Eval sumdlogdiv_b_num Horner step: add coefficient_38
    let t236 = circuit_mul(t235, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t237 = circuit_add(in145, t236); // Eval sumdlogdiv_b_num Horner step: add coefficient_37
    let t238 = circuit_mul(t237, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t239 = circuit_add(in144, t238); // Eval sumdlogdiv_b_num Horner step: add coefficient_36
    let t240 = circuit_mul(t239, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t241 = circuit_add(in143, t240); // Eval sumdlogdiv_b_num Horner step: add coefficient_35
    let t242 = circuit_mul(t241, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t243 = circuit_add(in142, t242); // Eval sumdlogdiv_b_num Horner step: add coefficient_34
    let t244 = circuit_mul(t243, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t245 = circuit_add(in141, t244); // Eval sumdlogdiv_b_num Horner step: add coefficient_33
    let t246 = circuit_mul(t245, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t247 = circuit_add(in140, t246); // Eval sumdlogdiv_b_num Horner step: add coefficient_32
    let t248 = circuit_mul(t247, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t249 = circuit_add(in139, t248); // Eval sumdlogdiv_b_num Horner step: add coefficient_31
    let t250 = circuit_mul(t249, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t251 = circuit_add(in138, t250); // Eval sumdlogdiv_b_num Horner step: add coefficient_30
    let t252 = circuit_mul(t251, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t253 = circuit_add(in137, t252); // Eval sumdlogdiv_b_num Horner step: add coefficient_29
    let t254 = circuit_mul(t253, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t255 = circuit_add(in136, t254); // Eval sumdlogdiv_b_num Horner step: add coefficient_28
    let t256 = circuit_mul(t255, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t257 = circuit_add(in135, t256); // Eval sumdlogdiv_b_num Horner step: add coefficient_27
    let t258 = circuit_mul(t257, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t259 = circuit_add(in134, t258); // Eval sumdlogdiv_b_num Horner step: add coefficient_26
    let t260 = circuit_mul(t259, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t261 = circuit_add(in133, t260); // Eval sumdlogdiv_b_num Horner step: add coefficient_25
    let t262 = circuit_mul(t261, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t263 = circuit_add(in132, t262); // Eval sumdlogdiv_b_num Horner step: add coefficient_24
    let t264 = circuit_mul(t263, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t265 = circuit_add(in131, t264); // Eval sumdlogdiv_b_num Horner step: add coefficient_23
    let t266 = circuit_mul(t265, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t267 = circuit_add(in130, t266); // Eval sumdlogdiv_b_num Horner step: add coefficient_22
    let t268 = circuit_mul(t267, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t269 = circuit_add(in129, t268); // Eval sumdlogdiv_b_num Horner step: add coefficient_21
    let t270 = circuit_mul(t269, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t271 = circuit_add(in128, t270); // Eval sumdlogdiv_b_num Horner step: add coefficient_20
    let t272 = circuit_mul(t271, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t273 = circuit_add(in127, t272); // Eval sumdlogdiv_b_num Horner step: add coefficient_19
    let t274 = circuit_mul(t273, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t275 = circuit_add(in126, t274); // Eval sumdlogdiv_b_num Horner step: add coefficient_18
    let t276 = circuit_mul(t275, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t277 = circuit_add(in125, t276); // Eval sumdlogdiv_b_num Horner step: add coefficient_17
    let t278 = circuit_mul(t277, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t279 = circuit_add(in124, t278); // Eval sumdlogdiv_b_num Horner step: add coefficient_16
    let t280 = circuit_mul(t279, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t281 = circuit_add(in123, t280); // Eval sumdlogdiv_b_num Horner step: add coefficient_15
    let t282 = circuit_mul(t281, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t283 = circuit_add(in122, t282); // Eval sumdlogdiv_b_num Horner step: add coefficient_14
    let t284 = circuit_mul(t283, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t285 = circuit_add(in121, t284); // Eval sumdlogdiv_b_num Horner step: add coefficient_13
    let t286 = circuit_mul(t285, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t287 = circuit_add(in120, t286); // Eval sumdlogdiv_b_num Horner step: add coefficient_12
    let t288 = circuit_mul(t287, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t289 = circuit_add(in119, t288); // Eval sumdlogdiv_b_num Horner step: add coefficient_11
    let t290 = circuit_mul(t289, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t291 = circuit_add(in118, t290); // Eval sumdlogdiv_b_num Horner step: add coefficient_10
    let t292 = circuit_mul(t291, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t293 = circuit_add(in117, t292); // Eval sumdlogdiv_b_num Horner step: add coefficient_9
    let t294 = circuit_mul(t293, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t295 = circuit_add(in116, t294); // Eval sumdlogdiv_b_num Horner step: add coefficient_8
    let t296 = circuit_mul(t295, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t297 = circuit_add(in115, t296); // Eval sumdlogdiv_b_num Horner step: add coefficient_7
    let t298 = circuit_mul(t297, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t299 = circuit_add(in114, t298); // Eval sumdlogdiv_b_num Horner step: add coefficient_6
    let t300 = circuit_mul(t299, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t301 = circuit_add(in113, t300); // Eval sumdlogdiv_b_num Horner step: add coefficient_5
    let t302 = circuit_mul(t301, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t303 = circuit_add(in112, t302); // Eval sumdlogdiv_b_num Horner step: add coefficient_4
    let t304 = circuit_mul(t303, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t305 = circuit_add(in111, t304); // Eval sumdlogdiv_b_num Horner step: add coefficient_3
    let t306 = circuit_mul(t305, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t307 = circuit_add(in110, t306); // Eval sumdlogdiv_b_num Horner step: add coefficient_2
    let t308 = circuit_mul(t307, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t309 = circuit_add(in109, t308); // Eval sumdlogdiv_b_num Horner step: add coefficient_1
    let t310 = circuit_mul(t309, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t311 = circuit_add(in108, t310); // Eval sumdlogdiv_b_num Horner step: add coefficient_0
    let t312 = circuit_mul(in216, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t313 = circuit_add(in215, t312); // Eval sumdlogdiv_b_den Horner step: add coefficient_54
    let t314 = circuit_mul(t313, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t315 = circuit_add(in214, t314); // Eval sumdlogdiv_b_den Horner step: add coefficient_53
    let t316 = circuit_mul(t315, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t317 = circuit_add(in213, t316); // Eval sumdlogdiv_b_den Horner step: add coefficient_52
    let t318 = circuit_mul(t317, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t319 = circuit_add(in212, t318); // Eval sumdlogdiv_b_den Horner step: add coefficient_51
    let t320 = circuit_mul(t319, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t321 = circuit_add(in211, t320); // Eval sumdlogdiv_b_den Horner step: add coefficient_50
    let t322 = circuit_mul(t321, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t323 = circuit_add(in210, t322); // Eval sumdlogdiv_b_den Horner step: add coefficient_49
    let t324 = circuit_mul(t323, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t325 = circuit_add(in209, t324); // Eval sumdlogdiv_b_den Horner step: add coefficient_48
    let t326 = circuit_mul(t325, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t327 = circuit_add(in208, t326); // Eval sumdlogdiv_b_den Horner step: add coefficient_47
    let t328 = circuit_mul(t327, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t329 = circuit_add(in207, t328); // Eval sumdlogdiv_b_den Horner step: add coefficient_46
    let t330 = circuit_mul(t329, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t331 = circuit_add(in206, t330); // Eval sumdlogdiv_b_den Horner step: add coefficient_45
    let t332 = circuit_mul(t331, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t333 = circuit_add(in205, t332); // Eval sumdlogdiv_b_den Horner step: add coefficient_44
    let t334 = circuit_mul(t333, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t335 = circuit_add(in204, t334); // Eval sumdlogdiv_b_den Horner step: add coefficient_43
    let t336 = circuit_mul(t335, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t337 = circuit_add(in203, t336); // Eval sumdlogdiv_b_den Horner step: add coefficient_42
    let t338 = circuit_mul(t337, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t339 = circuit_add(in202, t338); // Eval sumdlogdiv_b_den Horner step: add coefficient_41
    let t340 = circuit_mul(t339, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t341 = circuit_add(in201, t340); // Eval sumdlogdiv_b_den Horner step: add coefficient_40
    let t342 = circuit_mul(t341, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t343 = circuit_add(in200, t342); // Eval sumdlogdiv_b_den Horner step: add coefficient_39
    let t344 = circuit_mul(t343, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t345 = circuit_add(in199, t344); // Eval sumdlogdiv_b_den Horner step: add coefficient_38
    let t346 = circuit_mul(t345, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t347 = circuit_add(in198, t346); // Eval sumdlogdiv_b_den Horner step: add coefficient_37
    let t348 = circuit_mul(t347, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t349 = circuit_add(in197, t348); // Eval sumdlogdiv_b_den Horner step: add coefficient_36
    let t350 = circuit_mul(t349, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t351 = circuit_add(in196, t350); // Eval sumdlogdiv_b_den Horner step: add coefficient_35
    let t352 = circuit_mul(t351, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t353 = circuit_add(in195, t352); // Eval sumdlogdiv_b_den Horner step: add coefficient_34
    let t354 = circuit_mul(t353, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t355 = circuit_add(in194, t354); // Eval sumdlogdiv_b_den Horner step: add coefficient_33
    let t356 = circuit_mul(t355, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t357 = circuit_add(in193, t356); // Eval sumdlogdiv_b_den Horner step: add coefficient_32
    let t358 = circuit_mul(t357, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t359 = circuit_add(in192, t358); // Eval sumdlogdiv_b_den Horner step: add coefficient_31
    let t360 = circuit_mul(t359, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t361 = circuit_add(in191, t360); // Eval sumdlogdiv_b_den Horner step: add coefficient_30
    let t362 = circuit_mul(t361, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t363 = circuit_add(in190, t362); // Eval sumdlogdiv_b_den Horner step: add coefficient_29
    let t364 = circuit_mul(t363, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t365 = circuit_add(in189, t364); // Eval sumdlogdiv_b_den Horner step: add coefficient_28
    let t366 = circuit_mul(t365, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t367 = circuit_add(in188, t366); // Eval sumdlogdiv_b_den Horner step: add coefficient_27
    let t368 = circuit_mul(t367, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t369 = circuit_add(in187, t368); // Eval sumdlogdiv_b_den Horner step: add coefficient_26
    let t370 = circuit_mul(t369, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t371 = circuit_add(in186, t370); // Eval sumdlogdiv_b_den Horner step: add coefficient_25
    let t372 = circuit_mul(t371, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t373 = circuit_add(in185, t372); // Eval sumdlogdiv_b_den Horner step: add coefficient_24
    let t374 = circuit_mul(t373, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t375 = circuit_add(in184, t374); // Eval sumdlogdiv_b_den Horner step: add coefficient_23
    let t376 = circuit_mul(t375, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t377 = circuit_add(in183, t376); // Eval sumdlogdiv_b_den Horner step: add coefficient_22
    let t378 = circuit_mul(t377, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t379 = circuit_add(in182, t378); // Eval sumdlogdiv_b_den Horner step: add coefficient_21
    let t380 = circuit_mul(t379, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t381 = circuit_add(in181, t380); // Eval sumdlogdiv_b_den Horner step: add coefficient_20
    let t382 = circuit_mul(t381, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t383 = circuit_add(in180, t382); // Eval sumdlogdiv_b_den Horner step: add coefficient_19
    let t384 = circuit_mul(t383, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t385 = circuit_add(in179, t384); // Eval sumdlogdiv_b_den Horner step: add coefficient_18
    let t386 = circuit_mul(t385, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t387 = circuit_add(in178, t386); // Eval sumdlogdiv_b_den Horner step: add coefficient_17
    let t388 = circuit_mul(t387, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t389 = circuit_add(in177, t388); // Eval sumdlogdiv_b_den Horner step: add coefficient_16
    let t390 = circuit_mul(t389, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t391 = circuit_add(in176, t390); // Eval sumdlogdiv_b_den Horner step: add coefficient_15
    let t392 = circuit_mul(t391, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t393 = circuit_add(in175, t392); // Eval sumdlogdiv_b_den Horner step: add coefficient_14
    let t394 = circuit_mul(t393, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t395 = circuit_add(in174, t394); // Eval sumdlogdiv_b_den Horner step: add coefficient_13
    let t396 = circuit_mul(t395, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t397 = circuit_add(in173, t396); // Eval sumdlogdiv_b_den Horner step: add coefficient_12
    let t398 = circuit_mul(t397, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t399 = circuit_add(in172, t398); // Eval sumdlogdiv_b_den Horner step: add coefficient_11
    let t400 = circuit_mul(t399, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t401 = circuit_add(in171, t400); // Eval sumdlogdiv_b_den Horner step: add coefficient_10
    let t402 = circuit_mul(t401, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t403 = circuit_add(in170, t402); // Eval sumdlogdiv_b_den Horner step: add coefficient_9
    let t404 = circuit_mul(t403, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t405 = circuit_add(in169, t404); // Eval sumdlogdiv_b_den Horner step: add coefficient_8
    let t406 = circuit_mul(t405, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t407 = circuit_add(in168, t406); // Eval sumdlogdiv_b_den Horner step: add coefficient_7
    let t408 = circuit_mul(t407, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t409 = circuit_add(in167, t408); // Eval sumdlogdiv_b_den Horner step: add coefficient_6
    let t410 = circuit_mul(t409, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t411 = circuit_add(in166, t410); // Eval sumdlogdiv_b_den Horner step: add coefficient_5
    let t412 = circuit_mul(t411, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t413 = circuit_add(in165, t412); // Eval sumdlogdiv_b_den Horner step: add coefficient_4
    let t414 = circuit_mul(t413, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t415 = circuit_add(in164, t414); // Eval sumdlogdiv_b_den Horner step: add coefficient_3
    let t416 = circuit_mul(t415, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t417 = circuit_add(in163, t416); // Eval sumdlogdiv_b_den Horner step: add coefficient_2
    let t418 = circuit_mul(t417, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t419 = circuit_add(in162, t418); // Eval sumdlogdiv_b_den Horner step: add coefficient_1
    let t420 = circuit_mul(t419, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t421 = circuit_add(in161, t420); // Eval sumdlogdiv_b_den Horner step: add coefficient_0
    let t422 = circuit_inverse(t421);
    let t423 = circuit_mul(t311, t422);
    let t424 = circuit_mul(in1, t423);
    let t425 = circuit_add(t207, t424);
    let t426 = circuit_mul(in2, t425);

    let modulus = modulus;

    let mut circuit_inputs = (t426,).new_inputs();
    // Prefill constants:

    // Fill inputs:
    circuit_inputs = circuit_inputs.next_2(A.x); // in0
    circuit_inputs = circuit_inputs.next_2(A.y); // in1
    circuit_inputs = circuit_inputs.next_2(coeff); // in2

    for val in SumDlogDivBatched.a_num {
        circuit_inputs = circuit_inputs.next_2(*val);
    }

    for val in SumDlogDivBatched.a_den {
        circuit_inputs = circuit_inputs.next_2(*val);
    }

    for val in SumDlogDivBatched.b_num {
        circuit_inputs = circuit_inputs.next_2(*val);
    }

    for val in SumDlogDivBatched.b_den {
        circuit_inputs = circuit_inputs.next_2(*val);
    }
    // in3 - in216

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let res: u384 = outputs.get_output(t426);
    return (res,);
}

impl CircuitDefinition48<
    E0,
    E1,
    E2,
    E3,
    E4,
    E5,
    E6,
    E7,
    E8,
    E9,
    E10,
    E11,
    E12,
    E13,
    E14,
    E15,
    E16,
    E17,
    E18,
    E19,
    E20,
    E21,
    E22,
    E23,
    E24,
    E25,
    E26,
    E27,
    E28,
    E29,
    E30,
    E31,
    E32,
    E33,
    E34,
    E35,
    E36,
    E37,
    E38,
    E39,
    E40,
    E41,
    E42,
    E43,
    E44,
    E45,
    E46,
    E47,
> of core::circuit::CircuitDefinition<
    (
        CE<E0>,
        CE<E1>,
        CE<E2>,
        CE<E3>,
        CE<E4>,
        CE<E5>,
        CE<E6>,
        CE<E7>,
        CE<E8>,
        CE<E9>,
        CE<E10>,
        CE<E11>,
        CE<E12>,
        CE<E13>,
        CE<E14>,
        CE<E15>,
        CE<E16>,
        CE<E17>,
        CE<E18>,
        CE<E19>,
        CE<E20>,
        CE<E21>,
        CE<E22>,
        CE<E23>,
        CE<E24>,
        CE<E25>,
        CE<E26>,
        CE<E27>,
        CE<E28>,
        CE<E29>,
        CE<E30>,
        CE<E31>,
        CE<E32>,
        CE<E33>,
        CE<E34>,
        CE<E35>,
        CE<E36>,
        CE<E37>,
        CE<E38>,
        CE<E39>,
        CE<E40>,
        CE<E41>,
        CE<E42>,
        CE<E43>,
        CE<E44>,
        CE<E45>,
        CE<E46>,
        CE<E47>,
    ),
> {
    type CircuitType =
        core::circuit::Circuit<
            (
                E0,
                E1,
                E2,
                E3,
                E4,
                E5,
                E6,
                E7,
                E8,
                E9,
                E10,
                E11,
                E12,
                E13,
                E14,
                E15,
                E16,
                E17,
                E18,
                E19,
                E20,
                E21,
                E22,
                E23,
                E24,
                E25,
                E26,
                E27,
                E28,
                E29,
                E30,
                E31,
                E32,
                E33,
                E34,
                E35,
                E36,
                E37,
                E38,
                E39,
                E40,
                E41,
                E42,
                E43,
                E44,
                E45,
                E46,
                E47,
            ),
        >;
}
impl MyDrp_48<
    E0,
    E1,
    E2,
    E3,
    E4,
    E5,
    E6,
    E7,
    E8,
    E9,
    E10,
    E11,
    E12,
    E13,
    E14,
    E15,
    E16,
    E17,
    E18,
    E19,
    E20,
    E21,
    E22,
    E23,
    E24,
    E25,
    E26,
    E27,
    E28,
    E29,
    E30,
    E31,
    E32,
    E33,
    E34,
    E35,
    E36,
    E37,
    E38,
    E39,
    E40,
    E41,
    E42,
    E43,
    E44,
    E45,
    E46,
    E47,
> of Drop<
    (
        CE<E0>,
        CE<E1>,
        CE<E2>,
        CE<E3>,
        CE<E4>,
        CE<E5>,
        CE<E6>,
        CE<E7>,
        CE<E8>,
        CE<E9>,
        CE<E10>,
        CE<E11>,
        CE<E12>,
        CE<E13>,
        CE<E14>,
        CE<E15>,
        CE<E16>,
        CE<E17>,
        CE<E18>,
        CE<E19>,
        CE<E20>,
        CE<E21>,
        CE<E22>,
        CE<E23>,
        CE<E24>,
        CE<E25>,
        CE<E26>,
        CE<E27>,
        CE<E28>,
        CE<E29>,
        CE<E30>,
        CE<E31>,
        CE<E32>,
        CE<E33>,
        CE<E34>,
        CE<E35>,
        CE<E36>,
        CE<E37>,
        CE<E38>,
        CE<E39>,
        CE<E40>,
        CE<E41>,
        CE<E42>,
        CE<E43>,
        CE<E44>,
        CE<E45>,
        CE<E46>,
        CE<E47>,
    ),
>;

#[inline(never)]
pub fn is_on_curve_bn254(p: G1Point, modulus: CircuitModulus) -> bool {
    // INPUT stack
    // y^2 = x^3 + 3
    let (in0, in1) = (CE::<CI<0>> {}, CE::<CI<1>> {});
    let y2 = circuit_mul(in1, in1);
    let x2 = circuit_mul(in0, in0);
    let x3 = circuit_mul(in0, x2);
    let y2_minus_x3 = circuit_sub(y2, x3);

    let mut circuit_inputs = (y2_minus_x3,).new_inputs();
    // Prefill constants:

    // Fill inputs:
    circuit_inputs = circuit_inputs.next_2(p.x); // in0
    circuit_inputs = circuit_inputs.next_2(p.y); // in1

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let zero_check: u384 = outputs.get_output(y2_minus_x3);
    return zero_check == u384 { limb0: 3, limb1: 0, limb2: 0, limb3: 0 };
}

