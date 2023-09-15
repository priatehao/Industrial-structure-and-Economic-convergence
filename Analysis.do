bysort 省份(year): gen order = _n
                       egen cntry = group(省份)
gen lnSk=ln(Sk)
  gen lnSh=ln(Sh)
  replace lnSk =0 if missing(lnSk)
   replace lnSh =0 if missing(lnSh)					   
gen y= ln(sjrjgdp)

xtabond2 y l.y lnSk lnSh diseqtwo diseqthree djyfetwo djyfethree i.year,gmm(y,lag(2 3))gmm(diseqtwo,lag(2 3))gmm(diseqthree,lag(2 3))gmm(djyfetwo,lag(2 3))gmm(djyfethree,lag(2 3))iv(lnSk lnSh i.year) twostep robust

xtabond2 y l.y lnSk lnSh diseqtwo diseqthree i.year,gmm(y,lag(2 3))gmm(diseqtwo,lag(2 4))gmm(diseqthree,lag(2 3))iv(lnSk lnSh i.year) twostep robust

xtabond2 y1 l.y lnSk lnSh djyfetwo djyfethree ,gmm(y1,lag(2 3)collapse)gmm(djyfetwo ,lag(2 3))gmm(djyfethree ,lag(1 2)collapse)iv(lnSk lnSh) twostep robust
///系统GMM

xtreg y l.y lnSk lnSh diseqtwo diseqthree  i.year,fe r
xtreg y l.y lnSk lnSh djyfetwo djyfethree i.year,fe r
xtreg y l.y lnSk lnSh diseqtwo diseqthree jyfetwo jyfethree i.year,fe r
///固定面板回归
qui xtreg y l.y lnSk lnSh diseqtwo diseqthree jyfetwo jyfethree,fe 
qui xtreg y l.y lnSk lnSh diseqtwo diseqthree jyfetwo jyfethree,re 
///豪斯曼检验


  xtabond2 one l.lnone ,gmm(one,lag(2 3))iv(i.year) robust
  xtabond2 two l.lntwo ,gmm(two,lag(2 3))iv(i.year) robust
  xtabond2 three l.lnthree ,gmm(three,lag(2 3))iv(i.year) robust
  ////绝对收敛
  
  
xtabond2 y l.y lnSk lnSh diseqgrowth djyfegrowth i.year,gmm(y,lag(2 3))gmm(diseqgrowth,lag(2 3))gmm(djyfegrowth,lag(2 3))iv(lnSk lnSh i.year) twostep robust

xtabond2 y l.y lnSk lnSh  djyfegrowth i.year,gmm(y,lag(2 3))gmm(djyfegrowth,lag(2 3))iv(lnSk lnSh i.year) twostep robust

xtabond2 y l.y lnSk lnSh diseqgrowth  i.year,gmm(y,lag(2 3))gmm(diseqgrowth,lag(2 3))giv(lnSk lnSh i.year) twostep robust
///进一步检验






