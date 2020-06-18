//	imported from https://groups.google.com/group/SketchUp3d/browse_thread/thread/68865aa2fc881e30/26a9ccea8c3c9af1 (work of TaffGoch in public domain) by david buzz (GPLv2)
//	removed 'mcad' dependency by qharley
//	cleaned up by feng ling (levincoolxyz)
//	use the "use" directive, please.
//	module airfoil() default to NACA-8412
//	camber_max - percent figure. ( range 0-9 )
//	camber_position - tenths   ( range 0-9 )
//	thickness - percentage relative to chord   ( range 0-99 )

NOF_POINTS = 25; // datapoints on each of upper and lower surfaces
xxp = [for (i = [0 : NOF_POINTS]) 1 - cos((i - 1) * 90 / (NOF_POINTS - 1))];
xx = [for (i = [1 : NOF_POINTS]) xxp[i]];

pre_yt = [
    for (i = [0 : NOF_POINTS])
    5 * (
        0.2969 * pow(xxp[i], 0.5) - 0.126 * xxp[i] - 0.3516 * pow(xxp[i], 2)
        + 0.2843 * pow(xxp[i], 3) - 0.1015 * pow(xxp[i], 4)
    )
];
dxx = [for (i = [0 : NOF_POINTS - 1]) xxp[i + 1] - xxp[i]];

	
module airfoil(camber_max = 8, camber_position = 4, thickness = 12) {
	m = camber_max / 100;
	p = camber_position / 10;
	t = thickness / 100;

	ycp = [
        for (xx_i = xxp)
        xx_i < p ?
            m / pow(p, 2) * (2 * p * xx_i - pow(xx_i, 2)) :
            m / pow(1 - p, 2) * (1 - 2 * p + 2 * p * xx_i - pow(xx_i, 2))
    ];
    yc = [for (i = [1 : NOF_POINTS]) ycp[i]];

    yt = t * pre_yt;
    dyc = [for (i = [0 : NOF_POINTS - 1]) ycp[i + 1] - ycp[i]];
    atan_dyc_dxx = [for (i = [0 : NOF_POINTS - 1]) atan(dyc[i] / dxx[i])];
    yt_sin_atan_dyc_dxx = [for (i = [0 : NOF_POINTS - 1]) yt[i] * sin(atan_dyc_dxx[i])];
    yt_cos_atan_dyc_dxx = [for (i = [0 : NOF_POINTS - 1]) yt[i] * cos(atan_dyc_dxx[i])];

    xu = xx - yt_sin_atan_dyc_dxx;
    yu = yc + yt_cos_atan_dyc_dxx;
    xl = xx + yt_sin_atan_dyc_dxx;
    yl = yc - yt_cos_atan_dyc_dxx;

	polygon(
        points=[
            for (i = [0 : NOF_POINTS - 1]) [xu[i], yu[i]],  // upper side front-to-back
            for (i = [NOF_POINTS - 1: -1 : 1]) [xl[i], yl[i]]  // lower side back-to-front
        ]
    );
}
