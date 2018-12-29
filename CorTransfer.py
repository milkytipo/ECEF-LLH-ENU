# -*- coding: utf-8 -*-
# @Author: wuzida
# @Date:   2018-12-28 15:20:54
# @Last Modified by:   wuzida
# @Last Modified time: 2018-12-29 16:49:14
import geo
import scipy.io as sio
from numpy import*

load_llh = 'vehicle_llh.mat '
llh = sio.loadmat(load_llh)

llh_ref = llh['llh'][0]
enu = zeros(shape=(len(llh['llh']),3))
llh1  = llh['llh']  #original llh

for i in range(len(llh1)):

	enu_temp = geo.geodetic_to_enu(llh1[i][0],llh1[i][1],llh1[i][2],llh_ref[0],llh_ref[1],llh_ref[2])
	enu[i] = enu_temp

xy = zeros_like(llh1)
llh2 = zeros_like(llh1)  #transfered
enu2 = enu +xy

for j in range(len(enu2)):

	llh_temp = geo.enu_to_geodetic(enu2[j][0],enu2[j][1],enu2[j][2],llh_ref[0],llh_ref[1],llh_ref[2])
	llh2[j] = llh_temp

print(llh2 - llh1)
	


