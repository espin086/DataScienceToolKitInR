library(caret) #used to train models
library(doMC)
registerDoMC(cores = 4)

#######################################
#Training Methodology
set.seed(2015)
fitControl <- trainControl(## 10-fold CV
        method = "repeatedcv",
        number = 5,
        ## repeated ten times
        repeats = 10)


#######################################
#Machine Learning Models


run.models <- function(training, score){

        xgbTree <- train(target ~ ., 
                 method="xgbTree",
                 trControl = fitControl, 
                 data = training)
        xgbTree.score <- predict(xgbTree, score)
        
        rf <- train(target ~ ., 
                         method="rf",
                         trControl = fitControl, 
                         data = training)
        rf.score <- predict(rf, score)
        
        nnet <- train(target ~ ., 
                         method="nnet",
                         trControl = fitControl, 
                         data = training)
        nnet.score <- predict(nnet, score)
        
        glm <- train(target ~ ., 
                      method="glm",
                      trControl = fitControl, 
                      data = training)
        glm.score <- predict(glm, score)
        
        scored <- list(xgbTree.score, rf.score , nnet.score, glm.score)
        return(scored)
        

}



