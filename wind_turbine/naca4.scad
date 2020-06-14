//	imported from https://groups.google.com/group/SketchUp3d/browse_thread/thread/68865aa2fc881e30/26a9ccea8c3c9af1 (work of TaffGoch in public domain) by david buzz (GPLv2)
//	removed 'mcad' dependency by qharley
//	cleaned up by feng ling (levincoolxyz)
//	use the "use" directive, please.
//	module airfoil() default to NACA-8412
//	camber_max - percent figure. ( range 0-9 )
//	camber_position - tenths   ( range 0-9 )
//	thickness - percentage relative to chord   ( range 0-99 )

NOF_POINTS = 25; // datapoints on each of upper and lower surfaces
xx = [for (i = [0 : NOF_POINTS]) 1 - cos((i - 1) * 90 / (NOF_POINTS - 1))];
pre_yt = [
    for (i = [0 : NOF_POINTS])
    5 * (
        0.2969 * pow(xx[i], 0.5) - 0.126 * xx[i] - 0.3516 * pow(xx[i], 2)
        + 0.2843 * pow(xx[i], 3) - 0.1015 * pow(xx[i], 4)
    )
];
dxx = [undef, for (i = [1 : NOF_POINTS]) xx[i] - xx[i - 1]];

	
module airfoil(camber_max = 8, camber_position = 4, thickness = 12) {
    //echo("xx", xx);
	m = camber_max / 100;
	p = camber_position / 10;
	t = thickness / 100;
	
    yt = t * pre_yt;

	yc = [
        for (xx_i = xx)
        xx_i < p ?
            m / pow(p, 2) * (2 * p * xx_i - pow(xx_i, 2)) :
            m / pow(1 - p, 2) * (1 - 2 * p + 2 * p * xx_i - pow(xx_i, 2))
    ];

    /*
    dyc = [undef, for (i = [1 : NOF_POINTS]) yc[i] - yc[i - 1]];
    atan_dyc_dxx = [undef, for (i = [1 : NOF_POINTS]) atan(dyc[i] / dxx[i])];
    yt_sin_atan_dyc_dxx = [undef, for (i = [1 : NOF_POINTS]) yt[i] * sin(atan_dyc_dxx[i])];
    yt_cos_atan_dyc_dxx = [undef, for (i = [1 : NOF_POINTS]) yt[i] * cos(atan_dyc_dxx[i])];
    */

    dyc = [undef, for (i = [1 : NOF_POINTS]) yc[i] - yc[i - 1]];
    atan_dyc_dxx = [undef, for (i = [1 : NOF_POINTS]) atan(dyc[i] / dxx[i])];
    yt_sin_atan_dyc_dxx = [undef, for (i = [1 : NOF_POINTS]) yt[i] * sin(atan_dyc_dxx[i])];
    yt_cos_atan_dyc_dxx = [undef, for (i = [1 : NOF_POINTS]) yt[i] * cos(atan_dyc_dxx[i])];
    echo(atan_dyc_dxx);

	xu = [
        for (j = [1 : NOF_POINTS])
        xx[j] - yt_sin_atan_dyc_dxx[j]
    ];

	yu = [
        for (j = [1 : NOF_POINTS])
        yc[j] + yt_cos_atan_dyc_dxx[j]
    ];
	xl = [
        for (j = [1 : NOF_POINTS])
        xx[j] + yt_sin_atan_dyc_dxx[j]
    ];
	yl = [
        for (j = [1 : NOF_POINTS])
        yc[j] - yt_cos_atan_dyc_dxx[j]
    ];

	polygon(
        points=[
            for (i = [0 : NOF_POINTS - 1]) [xu[i], yu[i]],  // upper side front-to-back
            for (i = [NOF_POINTS - 1: -1 : 1]) [xl[i], yl[i]]  // lower side back-to-front
        ]
    ); 
}

//airfoil();
//airfoil(0,0,10);
