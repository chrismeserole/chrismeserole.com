data <- read.csv("http://chrismeserole.com/assets/data/laborforce.csv")
names(data)

data$lfp2<-rep(0,length(data$lfp))
data$lfp2[as.numeric(data$lfp)==1]<-1

(mod_glm<-glm(lfp2~k5+k618+age+wc+hc+lwg+inc,data=data, family=binomial(link=logit)))
logLik(mod_glm)
vcov(mod_glm)

logistic.lik<-function(param,dat)
{
  xb <-param[1]*1 + param[2]*dat$k5 + param[3]*dat$k618 +param[4]*dat$age + param[5]*dat$wc + param[6]*dat$lwg + param[7]*dat$inc  #linear predictor
	g_x<-1/(1+exp(-xb)) #p(Y=1 | betas)
	LL<-sum(dat$Respond*log(g_x)+(1-dat$Respond)*log(1-g_x))
	return(-LL)  #returns the negative LL since by default optim minimizes 
}

logistic.lik<-function(par,dat)
{
	require(arm)
  xb<-par[1]*1+par[2]*dat$k5 #linear predictor
	print(par)
	g_x<-invlogit(-(xb)) #p(Y=1 | betas)
	LL<-sum(dat$Respond*log(g_x)+(1-dat$Respond)*log(1-g_x))
	return(-LL)  #returns the negative LL since by default optim minimizes 
}
 
result<-optim(c(0,0),logistic.lik, dat=data, hessian=TRUE, method="BFGS")
result 


data$wc<-as.numeric(data$wc)
result<-optim(rep(0,7),logistic.lik, dat=data, hessian=TRUE, method="BFGS")
result
