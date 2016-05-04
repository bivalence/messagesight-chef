#*******************************************************************************
#  Copyright (c) 2016 IBM Corporation and other Contributors.
# 
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  which accompanies this distribution, and is available at
#  http://www.eclipse.org/legal/epl-v10.html 
# 
#  Contributors:
#  IBM - Initial Contribution
#*******************************************************************************



#setup directory targets used by imaserver. Needed for cleanup/reset for now
default["imaserver-rpm"]["imaserver"]["diag"]="/var/messagesight/diag"
default["imaserver-rpm"]["imaserver"]["data"]="/var/messagesight/data"
default["imaserver-rpm"]["imaserver"]["store"]="/var/messagesight/store"
