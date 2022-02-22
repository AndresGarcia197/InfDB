*Obtenemos un resumen de los datos
sum
*Generamos la temporalidad de los datos para poder usarlos como serie de tiempo
gen date = ym(1982,2) +_n-1
format date %tm
tsset date
*Graficamos la inflación subyacente
tsline InfSub2

*Pruebas de Dickey-Fuller
dfuller InfSub
dfuller InfSub, trend
dfuller InfSub, drift

*Generamos los autocorrelogramas y los autocorrelogramas parciales
corrgram InfSub
ac InfSub
pac InfSub
*Generamos los modelos


*ARIMA2(1,0,10)
arima InfSub, arima(1,0,10)
predict  ARIMA2, dynamic(tm(2021m6))
estat ic
twoway (line InfSub2 date) (line ARIMA2 date)
gen Dif2 = InfSub2 - ARIMA2


*ARIMA3(1,0,12)
arima InfSub, arima(1,0,12)
predict  ARIMA3, dynamic(tm(2021m8))
twoway (line InfSub date) (line ARIMA3 date)
gen Dif3 = InfSub - ARIMA3
estat ic

*ARIMA4(2,0,10)
arima InfSub, arima(2,0,10)
predict  ARIMA4, dynamic(tm(2021m8))
twoway (line InfSub date) (line ARIMA4 date)
gen Dif4 = InfSub - ARIMA4
estat ic

*ARIMA5(2,0,12)
arima InfSub, arima(2,0,12)
predict  ARIMA5, dynamic(tm(2021m8))
twoway (line InfSub date) (line ARIMA5 date)
gen Dif5 = InfSub - ARIMA5
estat ic

*Prueba DFuller para las diferencias
dfuller Dif3
dfuller Dif3, trend
dfuller Dif3, drift

dfuller Dif5
dfuller Dif5, trend
dfuller Dif5, drift 

*Relizamos el pronostico.
arima InfSub_Ag, arima(1,0,12)
predict  ARIMA3, dynamic(tm(2022m8))
twoway (line InfSub_Ag date) (line ARIMA3 date)

arima InfSub_Ag, arima(2,0,12)
predict  ARIMA5, dynamic(tm(2022m8))
twoway (line InfSub_Ag date) (line ARIMA5 date)

*Pruebas del ultimo modelo propuesto

dfuller Dif5
dfuller Dif5, trend
dfuller Dif5, drift 

arima InfSub_Ag, arima(2,0,10)
predict  ARIMA6, dynamic(tm(2022m8))
twoway (line InfSub_Ag date) (line ARIMA6 date)

*Grafica de las diferencias
twoway (line Dif2 date) (line Dif3 date) (line Dif4 date)  (line Dif5 date)


