# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    vars.mk                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2024/10/08 14:22:48 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

export SV			:= nginx
export APP			:= wordpress
export DB			:= mariadb
export DATADIR		:= $(HOME)/data
export BASEDOMAIN	:= 42.fr
export ENVFILE		:= ./.env
SRCDIR				:= ./srcs
export SUBSRCDIR	:= ./requirements
YAML				:= -f $(SRCDIR)/docker-compose.yml
FIX_PJ				:= incep
FIX_IMG				:= $(FIX_PJ)-img
FIX_CTNR			:= $(FIX_PJ)-ctnr
FIX_VOL				:= $(FIX_PJ)-vol
CERT_DIR			:= $(SRCDIR)/$(SUBSRCDIR)/$(APP)/ssl
KEY_PATH			:= $(CERT_DIR)/server.key
CSR_PATH			:= $(CERT_DIR)/server.csr
CERT_PATH			:= $(CERT_DIR)/server.crt
export NW			:= $(FIX_PJ)-nw
export IMG_SV		:= $(FIX_IMG)_$(SV)
export IMG_APP		:= $(FIX_IMG)_$(APP)
export IMG_DB		:= $(FIX_IMG)_$(DB)
export CTNR_SV		:= $(FIX_CTNR)_$(SV)
export CTNR_APP		:= $(FIX_CTNR)_$(APP)
export CTNR_DB		:= $(FIX_CTNR)_$(DB)
export VOL_APP		:= $(FIX_VOL)_$(APP)
export VOL_DB		:= $(FIX_VOL)_$(DB)
include $(SRCDIR)/.env
ifeq ("$(USER_42)", "")
	export DOMAIN	:= $(USER).$(BASEDOMAIN)
else
	export DOMAIN	:= $(USER_42).$(BASEDOMAIN)
endif
export MYSQL_ROOT_PASSWORD
export WP_DB_NAME
export WP_DB_USER
export WP_DB_PASSWORD
export WP_TITLE
export WP_ADMIN_USER
export WP_ADMIN_PASSWORD
export WP_ADMIN_EMAIL
export WP_SUB_USER
export WP_SUB_PASSWORD
export WP_SUB_EMAIL
export IP_SUBNET	:= 172.30.0.0/24
export IP_SV		:= 172.30.0.2
export IP_APP		:= 172.30.0.3
export IP_DB		:= 172.30.0.4
HOSTS_EXISTS		:= $(shell cat /etc/hosts | grep -E $(DOMAIN))
