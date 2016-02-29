//
s.boot;
// s.quit;
s.scope(2,0);//si evaluas esto despues de bootear, genera nodo 1000
//master
(
SynthDef(\master,{|gate=1|
	var mast,env;
	mast = In.ar(20);
	mast = FreeVerb.ar(mast,1,0.1,0.05);
	mast = CombC.ar(mast,0.07,0.025,0.25);
	env = EnvGen.ar(Env.asr(0.01,0.98,0.01),gate);
	Out.ar(0,Pan2.ar(mast*env,[1,-0.99]));
}).add;
);
Synth(\master);//primera vez que se evalua
s.queryAllNodes;//si se evalua Synth.replace hay que saber cual nodo es el primero
Synth.replace(1060,\master);//reemplaza el primer nodo (master)
//1
Synth(\uno);
(
SynthDef(\uno, {|gate=1|
	var osc,env,linea,lineaMul;
	lineaMul = TRand.ar(100,10000,Impulse.kr(4));
	linea = XLine.kr(400,1000,0.1);
	osc = LFTri.ar(Blip.ar(4,400,120,1200),0,0.5);
	osc = FreeVerb.ar(osc,0.5,0.25,0.1);
	osc = RLPF.ar(osc,linea,0.1);
	osc = PitchShift.ar(osc,0.05,linea/lineaMul);
	env = EnvGen.ar(Env.perc(0.25,0.05),gate,doneAction:2);
	Out.ar(20,osc*env);
}).add;
);
Synth(\uno);
//Secuencia
(
Tdef(\secuenciauno, {
	var pw = Pxrand((100..1000),inf).asStream;//Pslide([],inf).asSteam;
	inf.do({
		Synth(\uno);
		"si?".post;
		2.wait;
	});
});
);
Tdef(\secuenciauno).play;
Tdef(\secuenciauno).stop;
//
Help.gui;