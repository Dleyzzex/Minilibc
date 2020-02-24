##
## EPITECH PROJECT, 2020
## Makefile
## File description:
## Makefile
##

DIR_SRC	=	./src/

SRC		=	$(DIR_SRC)strlen.asm \
			$(DIR_SRC)strchr.asm \
			$(DIR_SRC)memset.asm \
			$(DIR_SRC)memcpy.asm \
			$(DIR_SRC)strcmp.asm \
			$(DIR_SRC)memmove.asm \
			$(DIR_SRC)strncmp.asm \
			$(DIR_SRC)strcasecmp.asm \
			$(DIR_SRC)rindex.asm \

NAME	=	libasm.so

OBJ		=	$(SRC:.asm=.o)

all		:	$(NAME)

%.o: %.asm
	nasm -f elf64 $< -o $@

$(NAME)	:	$(OBJ)
			ld $(OBJ) -shared -o $(NAME)

clean	:
			@rm -f $(OBJ)

fclean	:	clean
			@rm -f $(NAME)

re		:	fclean all
